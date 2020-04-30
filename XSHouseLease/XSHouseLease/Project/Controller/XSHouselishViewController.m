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

#define number 20
@interface XSHouselishViewController ()
<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong) XSRegionSearchView *searcView;
@property (nonatomic,strong) SDCycleScrollView  *cycleScrollView;
@property (nonatomic,strong) XSCollectionView   *collectionView;
@property (nonatomic,strong) XSRoundedBtn1View  *moreView;

@property(nonatomic,strong) UITableView *tableView;


@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray<XSHouseModuleModel *> *headerArray;
@end

@implementation XSHouselishViewController
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
        _searcView = [[XSRegionSearchView alloc]init];
        _searcView.searchBlack = ^(NSString *searhKey) {
            STRONG_SELF;
            [self loadData];
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
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 168) delegate:self placeholderImage:nil];
        _cycleScrollView.imageURLStringsGroup = nil;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    }
    return _cycleScrollView;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (XSCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[XSCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.houseType==XSBHouseType_Rent?210:105)];
    }
    return _collectionView;
}
- (XSRoundedBtn1View *)moreView{
    if (!_moreView) {
        _moreView = [[XSRoundedBtn1View alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 38)];
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
    listvc.house_id = self.house_id;
    listvc.searchDict = self.searchDict;
    [[NSObject getTopViewController].navigationController pushViewController:listvc animated:YES];
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
    if (self.searchDict) {
        self.navigationItem.titleView = self.searcView;
    }

    [self.view addSubview:self.tableView];

    if (self.module) {
        if (self.houseType == XSBHouseType_New) {
            self.tableView.tableHeaderView = self.collectionView;
            self.headerArray = [XSPublicServer sharedInstance].newhouseConditionArray;

         }else if (self.houseType == XSBHouseType_Rent){
             self.tableView.tableHeaderView = self.collectionView;
             self.headerArray = [XSPublicServer sharedInstance].renthouseConditionArray;

         }else if (self.houseType == XSBHouseType_old){
             self.tableView.tableHeaderView = self.cycleScrollView;
             [self oldimageURLStringsGroup:^(NSArray *array) {
                 self.cycleScrollView.imageURLStringsGroup = array;
             }];
         }
    }
    [self.tableView reloadData];
    
    [self loadData];

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
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
                }else{
                    [self.array addObjectsFromArray:array];
                }
                if (self.nubmer > 0) {
                    self.tableView.tableFooterView = self.moreView;
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
