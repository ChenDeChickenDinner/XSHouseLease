//
//  XSHouselishViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouselishViewController.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseInfoShowModel.h"
#import "XSHouseDetailsController.h"
#import "XSHouseSubmitFirstViewController.h"
#import "XSCollectionView.h"
#import "ZHFilterMenuView.h"
#import "FilterDataUtil.h"
#import "XSSearchEstateController.h"

#define KMenuViewHeight      45
#define KHeadImageViewHeight 250
#define KStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define KNavBarHeight self.navigationController.navigationBar.frame.size.height
#define KNavbarAndStatusHieght (KStatusBarHeight+KNavBarHeight)
#define number 20
@interface XSHouselishViewController ()
<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ZHFilterMenuViewDelegate,
ZHFilterMenuViewDetaSource,UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableDictionary *searchDict;

@property (nonatomic,strong) XSRegionSearchView *searcView;
@property (nonatomic,strong) SDCycleScrollView  *cycleScrollView;
@property (nonatomic,strong) UIView  *cycleScrollBkView;


@property (nonatomic,strong) XSCollectionView   *collectionView;
@property (nonatomic,strong) XSRoundedBtn1View  *moreView;
@property (nonatomic, strong) ZHFilterMenuView *menuView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property(nonatomic,strong) UITableView *tableView;


@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray<XSHouseModuleModel *> *headerArray;
@end

@implementation XSHouselishViewController

- (BRProvinceModel *)cityModel{
    if (!_cityModel) {
        _cityModel = [XSUserServer sharedInstance].cityModel;
    }
    return _cityModel;
}
- (void)setEsModel:(XSHouseEsModel *)esModel{
    self.searchDict = nil;
    _esModel  = esModel;
    NSDictionary *dict = self.searchDict;
    NSLog(@"self.searchDict:%@",dict);
    if (self.isViewLoaded) {
        [self loadData];

    }
}
- (NSMutableDictionary *)searchDict{
    if (_searchDict == nil) {
        _searchDict = [NSMutableDictionary dictionary];
        [_searchDict  safeSetObject:self.cityModel.name forKey:@"city"];
        [_searchDict  safeSetObject:@(self.cityModel.code.intValue) forKey:@"cityId"];
        [_searchDict  safeSetObject:self.esModel.regionId forKey:@"regionId"];
        [_searchDict  safeSetObject:self.esModel.townId forKey:@"townId"];

    }
    return _searchDict;
}
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray<XSHouseModuleModel *> *)headerArray{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}
- (XSRegionSearchView *)searcView{
    if (!_searcView) {
        WEAK_SELF;
        _searcView = [[XSRegionSearchView alloc]initWithFrame:CGRectZero type:self.houseType];
        _searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 35);
        _searcView.searchBlack = ^(NSString *searhKey,XSBHouseType type) {
            STRONG_SELF;
//            [self loadData];
            for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[XSSearchEstateController class]]) {
                    XSSearchEstateController *newvc = (XSSearchEstateController *)vc;
                    newvc.cityModel = self.cityModel;
                    newvc.houseType = self.houseType;
                    newvc.searchBlock = ^(XSHouseEsModel * _Nonnull model,XSBHouseType houseType) {
                        if (self.houseType <= 0) {
                            self.houseType = houseType;
                        }
                        self.esModel = model;
                     };
                    [self.navigationController popToViewController:vc animated:YES];
                    return ;
                }
            }
            XSSearchEstateController *vc = [[XSSearchEstateController alloc]init];
            vc.cityModel = self.cityModel;
            vc.houseType = self.houseType;
            vc.searchBlock = ^(XSHouseEsModel * _Nonnull model,XSBHouseType houseType) {
            if (self.houseType <= 0) {
             self.houseType = houseType;
            }
            self.esModel = model;
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    return _searcView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        WEAK_SELF;
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.bounces = self.nubmer>0?NO:YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.source == XSBHouseInfoSource_MyPublish || self.source == XSBHouseInfoSource_MyWatch) {
            _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                STRONG_SELF;
                [self loadData];
            }];
            _tableView.mj_header.automaticallyChangeAlpha = YES;
        }
    }
    return _tableView;
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        UIView *bk= [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 168 + 15)];
        bk.backgroundColor = [UIColor hx_colorWithHexStr:@"#CCCCCC"];
        self.cycleScrollBkView = bk;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 168) delegate:self placeholderImage:nil];
        _cycleScrollView.imageURLStringsGroup = nil;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        [bk addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (XSCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[XSCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.houseType==XSBHouseType_Rent?240:135)];
        _collectionView.line = YES;
    }
    return _collectionView;
}
- (XSRoundedBtn1View *)moreView{
    if (!_moreView) {
        _moreView = [[XSRoundedBtn1View alloc]initWithFrame:CGRectMake(15, 0, self.view.width -30, 38)];
        _moreView.backgroundColor = [UIColor hx_colorWithHexStr:@"#E82B2B" alpha:0.3];
        [_moreView setTitle:@"更多房源推荐" forState:UIControlStateNormal];
        [_moreView setTitleColor:[UIColor hx_colorWithHexStr:@"#F9EAEA"] forState:UIControlStateNormal];
        [_moreView addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreView;
}
- (void)moreClick{
    XSHouselishViewController *listvc = [[XSHouselishViewController alloc]init];
    listvc.houseType = self.houseType;
    listvc.source = self.source;
    listvc.resource = self.resource;
    listvc.house_id = self.house_id;
    listvc.cityModel = self.cityModel;
    listvc.esModel = self.esModel;
    listvc.notHaveMenuView = YES;
    [[NSObject getTopViewController].navigationController pushViewController:listvc animated:YES];
}
- (ZHFilterMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[ZHFilterMenuView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), KMenuViewHeight) maxHeight:CGRectGetHeight(self.view.frame) - KMenuViewHeight];
        _menuView.zh_delegate = self;
        _menuView.zh_dataSource = self;
        _menuView.titleColor = [UIColor hx_colorWithHexStr:@"#444444"];
        _menuView.titleSelectedColor = [UIColor hx_colorWithHexStr:@"#E82B2B"];

        _menuView.itemBGColor = [UIColor hx_colorWithHexStr:@"#EFEFEF"];
//        _menuView.itemBGSelectedColor = [UIColor hx_colorWithHexStr:@"#E82B2B"];

        //下拉列表展示在window上，以应对列表视图展示的问题
        _menuView.showInWindow = YES;
        //移动后的menuView坐标转换在window上的minY值，showInWindow为YES时有效
        _menuView.inWindowMinY = KNavbarAndStatusHieght;
        _menuView.titleArr = @[@"区域",@"价格",@"户型",@"更多",@"排序"];
        _menuView.imageNameArr = @[@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow"];
//        _menuView.titleArr = @[@"区域"];
//          _menuView.imageNameArr = @[@"x_arrow"];
    }
    return _menuView;
}
//下拉菜单展示时禁止点击状态栏回到顶部，避免滑动后下拉框未消失的情况（贝壳找房是存在这样的问题）
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return !self.menuView.isOpen;
}

/** 确定回调 */
- (void)menuView:(ZHFilterMenuView *)menuView didSelectConfirmAtSelectedModelArr:(NSArray *)selectedModelArr{
//    NSArray *dictArr = [ZHFilterItemModel mj_keyValuesArrayWithObjectArray:selectedModelArr];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (ZHFilterItemModel *model in selectedModelArr) {
        if (model.key && model.selected) {
            
            [self dictManage:dict key:model.key value:model.code isinteger:model.isinteger];

            if (model.parentKey) {
                [dict safeSetObject:model.parentCode forKey:model.parentKey];
            }
            if ([model.key isEqualToString:@"totalPrice"]||[model.key isEqualToString:@"rentPrice"]) {
                NSArray *aray = [model.code componentsSeparatedByString:@"-"];
                [dict safeSetObject:aray.firstObject forKey:@"minPrice"];
                [dict safeSetObject:aray.lastObject forKey:@"maxPrice"];
                [dict removeObjectForKey:@"totalPrice"];
                [dict removeObjectForKey:@"rentPrice"];

            }


        }
    
        if (model.minPrice && model.maxPrice){
            [dict safeSetObject:model.minPrice forKey:@"minPrice"];
            [dict safeSetObject:model.maxPrice forKey:@"maxPrice"];
        }
    }
    if (dict.allKeys.count > 0) {
        self.searchDict = nil;
        for (NSString *key in dict.allKeys) {
            [self.searchDict safeSetObject:[dict safeObjectForKey:key] forKey:key];
        }
        NSLog(@"结果回调：%@",self.searchDict);

        [self loadData];
    }

}
- (void)dictManage:(NSMutableDictionary *)dict key:(NSString *)key value:(NSString *)value isinteger:(BOOL)isinteger{
    id oldValue = [dict safeObjectForKey:key];
    if (oldValue) {
        if ([oldValue isKindOfClass:[NSNumber class]]) {
            NSMutableArray *array = [NSMutableArray array];
            NSNumber *valye = (NSNumber *)oldValue;
            [array addObject:valye];
            [array addObject:@(value.intValue)];
            [dict safeSetObject:array forKey:key];
        }else if ([oldValue isKindOfClass:[NSArray class]]){
            NSMutableArray *array = [NSMutableArray arrayWithArray:oldValue];
           [array addObject:@(value.intValue)];
           [dict safeSetObject:array forKey:key];
        }else{
            [dict safeSetObject:isinteger?@(value.intValue):value forKey:key];
        }
    }else{
        [dict safeSetObject:isinteger?@(value.intValue):value forKey:key];
    }
}
/** 警告回调(用于错误提示) */
- (void)menuView:(ZHFilterMenuView *)menuView wangType:(ZHFilterMenuViewWangType)wangType{
    if (wangType == ZHFilterMenuViewWangTypeInput) {
        NSLog(@"请输入正确的价格区间！");
    }
}

/** 点击菜单回调 */
- (void)menuView:(ZHFilterMenuView *)menuView selectMenuAtTabIndex:(NSInteger)tabIndex{
    if (self.tableView.contentOffset.y < KHeadImageViewHeight && self.array.count > 0) {
        //设置等待时间，等区头悬停后再允许下拉框展示
        menuView.waitTime = 0.2f;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionTop)];
    } else {
        menuView.waitTime = 0.f;
    }
}

/** 返回每个 tabIndex 下的确定类型 */
- (ZHFilterMenuConfirmType)menuView:(ZHFilterMenuView *)menuView confirmTypeInTabIndex:(NSInteger)tabIndex{
    if (tabIndex == 4) {
        return ZHFilterMenuConfirmTypeSpeedConfirm;
    }
    return ZHFilterMenuConfirmTypeBottomConfirm;
}

/** 返回每个 tabIndex 下的下拉展示类型 */
- (ZHFilterMenuDownType)menuView:(ZHFilterMenuView *)menuView downTypeInTabIndex:(NSInteger)tabIndex{
    if (tabIndex == 0) {
        return ZHFilterMenuDownTypeTwoLists;
    } else if (tabIndex == 1) {
        return ZHFilterMenuDownTypeItemInput;
    } else if (tabIndex == 2) {
        return ZHFilterMenuDownTypeOnlyItem;
    } else if (tabIndex == 3) {
        return ZHFilterMenuDownTypeOnlyItem;
    } else if (tabIndex == 4) {
        return ZHFilterMenuDownTypeOnlyList;
    }
    return ZHFilterMenuDownTypeOnlyList;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.houseType = XSBHouseType_old;
//
//    self.module = YES;
//    self.searchDict = [NSMutableDictionary dictionary];
    
    if (self.title == nil) {
        if (self.source == XSBHouseInfoSource_MyPublish){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我发布的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我发布的二手房";
            }
        }else if (self.source == XSBHouseInfoSource_MyWatch){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我关注的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我关注的二手房";
            }else if (self.houseType == XSBHouseType_New){
                self.title = @"我关注的新房";
            }
        }else{
            self.title = @"猜你喜欢";
        }
    }
    if (self.source == XSBHouseInfoSource_keyPush && !self.notHaveMenuView) {
        self.navigationItem.titleView = self.searcView;
    }
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
    [self.view addSubview:self.tableView];

    if (self.module) {
        if (self.houseType == XSBHouseType_New) {
            self.tableView.tableHeaderView = self.collectionView;
            
            self.headerArray = [XSPublicServer sharedInstance].newhouseConditionArray;

         }else if (self.houseType == XSBHouseType_Rent){
             self.tableView.tableHeaderView = self.collectionView;
             self.headerArray = [XSPublicServer sharedInstance].renthouseConditionArray;

         }else if (self.houseType == XSBHouseType_old){
             UIView *view = self.cycleScrollView;
             self.tableView.tableHeaderView = self.cycleScrollBkView;
             [self oldimageURLStringsGroup:^(NSArray *array) {
                 self.cycleScrollView.imageURLStringsGroup = array;
             }];
         }
    }
    self.collectionView.array = self.headerArray ;
    [self.collectionView.collectionView reloadData];
    
    
    FilterDataUtil *dataUtil = [[FilterDataUtil alloc] init];
    
    self.menuView.filterDataArr = [dataUtil getTabDataByType:self.houseType mainCity:self.cityModel];
    [self.menuView beginShowMenuView];
    
    [self.tableView reloadData];
    
    [self loadData];

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, self.houseType==XSBHouseType_Rent?240:135);
    self.menuView.maxHeight = CGRectGetHeight(self.view.frame) - KMenuViewHeight;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.menuView removeMenuList];
}

- (void)callMessage{
    
}

- (void)oldimageURLStringsGroup:(void(^)(NSArray *array))black{
    [self.subInfoInterface secondhousebunnerListWithDict:self.searchDict callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil) {
            if (responseModel.code.intValue == SuccessCode) {
                NSMutableArray *array = [XSHouseInfoShowModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                NSMutableArray *imags = [NSMutableArray array];
                for (XSHouseInfoShowModel *model in array) {
                    [imags addObject:model.firstImg];
                }
                if (black) {
                    black(imags);
                }
            }
        }
    }];
}


#pragma mark -数据请求
- (void)loadData{
    WEAK_SELF;
    [self.subInfoInterface houseLisetWith:self.houseType source:self.source resource:self.resource house_id:self.house_id?self.house_id.stringValue:@"" KeyVales:self.searchDict per_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [self.tableView.mj_header endRefreshing];
          if (error == nil) {
            [self.array removeAllObjects];
            if (responseModel.code.intValue == SuccessCode) {
                NSMutableArray *array = [XSHouseInfoShowModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                
                for (XSHouseInfoShowModel *model in array) {
                     model.source = self.source;
                     model.houseType = self.houseType;
                     model.clickEditStatu = ^(NSNumber * _Nonnull status, NSNumber * _Nonnull houseID) {
                         STRONG_SELF;
                         [self editHouseStatusWith:status houseId:houseID];
                     };
                 }
                
                
                if (self.nubmer> 0 && array.count >= self.nubmer) {
                    for (int i = 0; i < self.nubmer; i++) {
                        [self.array addObject:array[self.nubmer]];
                    }
                    self.tableView.tableFooterView = self.moreView;

                }else{
                    [self.array addObjectsFromArray:array];
                }
   
                if (self.callBackHeight) {
                    self.callBackHeight(145 * self.array.count + (self.nubmer>0?50:0));
                }
                [self.tableView reloadData];
            }
        }
        self.tableView.ly_emptyView = self.emptyView;
    }];


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.notHaveMenuView) {
        return nil;
    }else{
        return self.menuView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.notHaveMenuView) {
        return 0;
     }else{
         return KMenuViewHeight;
     }
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    static NSString *ID = @"XSHouseRentInfoCell";
    XSHouseRentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
           cell = [[NSBundle mainBundle] loadNibNamed:@"XSHouseInfoShowCell" owner:self options:nil].firstObject;
          NSLog(@"0000");
    }
    [cell updateWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    XSHouseDetailsController *vc = [[XSHouseDetailsController alloc]init];
    vc.houseType = self.houseType;
    vc.source = self.source;
    vc.houseid = model.house_id;
    [[NSObject getTopViewController].navigationController pushViewController:vc animated:YES];
  
}

#pragma mark -房屋重新编辑/状态更变
- (void)editHouseStatusWith:(NSNumber *)status houseId:(NSNumber *)houseId{
    if (status.integerValue == XSBHouseSubStatus_edit) {
        [self gethouseDetailsWithhouseid:houseId];
    }else{
        WEAK_SELF;
        [self.subInfoInterface editHouseStatusWithHouse_id:houseId houseType:XSBHouseType_Rent status:status.integerValue callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
             if (error == nil) {
                 if (responseModel.code.integerValue == SuccessCode) {
                     [self loadData];
                     [ProgressHUD showSuccess:@"操作成功"];
                 }else{
                     [ProgressHUD showError:error.description];
                 }
             }
         }];
    }
 
}

#pragma mark -重新编辑
- (void)gethouseDetailsWithhouseid:(NSNumber *)houseid{
    if (houseid == nil) {
        return;
    }
    WEAK_SELF;
    [ProgressHUD show];
    [self.subInfoInterface houseDetailsWithHouseType:self.houseType  house_id:houseid callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
         [ProgressHUD dismiss];
          if (error == nil) {
              if (responseModel.code.integerValue == SuccessCode) {
                  XSHouseInfoShowModel *model = [XSHouseInfoShowModel mj_objectWithKeyValues:responseModel.data];
                  XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
                  vc.subMitServer.houseType = self.houseType;
                  vc.subMitServer.renhousetInfoModel = model;
                  [self.navigationController pushViewController:vc animated:YES];
              }
         }
    }];
    
}
@end



















@interface XSHouseResourceListViewController ()

@end

@implementation XSHouseResourceListViewController
- ( NSArray<NSString *>*)getTitlese{
    return @[@"全部房源",@"个人房源",@"中介房源"];
}
- (NSArray<id<JXCategoryListContentViewDelegate>>*)getListVc{
    NSMutableArray *vcArray = [NSMutableArray array];
    for (int i = 0; i < [self getTitlese].count; i++) {
        XSHouselishViewController *vc  = [[XSHouselishViewController alloc]init];
        vc.houseType  = self.houseType;
        vc.source  = self.source;
        vc.notHaveMenuView = YES;
        if (i == 0) {
            vc.resource  = XSHouseSource_0;
        }else if (i == 1){
            vc.resource  = XSHouseSource_1;
        }else{
            vc.resource  = XSHouseSource_2;
        }
        [vcArray addObject:vc];
    }
    return vcArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.title == nil) {
        if (self.source == XSBHouseInfoSource_MyPublish){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我发布的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我发布的二手房";
            }
        }else if (self.source == XSBHouseInfoSource_MyWatch){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我关注的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我关注的二手房";
            }else if (self.houseType == XSBHouseType_New){
                self.title = @"我关注的新房";
            }
        }else{
            self.title = @"猜你喜欢";
        }
    }
}
@end
