//
//  FindHouseViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "FindHouseViewController.h"
#import "XSLocationSearchview.h"
#import "XSCollectionView.h"
#import "XSHouseModuleViewController.h"
#import "XSSearchEstateController.h"

@interface FindHouseViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (weak, nonatomic) IBOutlet XSLocationSearchview *searchView;
@property (weak, nonatomic) XSCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIView *resourceView;
@property (weak, nonatomic) IBOutlet UIView *searchCdView;
@property (weak, nonatomic) IBOutlet UIView *mustlookView;
@property (weak, nonatomic) IBOutlet UIView *loveView;
@property (weak, nonatomic) IBOutlet UIImageView *source0;
@property (weak, nonatomic) IBOutlet UIImageView *source1;
@property (nonatomic,assign) XSHouseSource resource;
@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *array;
@property (weak, nonatomic) IBOutlet UIView *changeTypeView;
@property(nonatomic,strong) JXCategoryTitleView *categoryView;
@property(nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong) NSMutableArray<id<JXCategoryListContentViewDelegate>> *listVc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loveViewHeight;

@end

@implementation FindHouseViewController
- (IBAction)source:(UIButton *)sender {

    if (sender.tag == XSHouseSource_1) {
        self.source0.image = [UIImage imageNamed:@"source0S"];
        self.source1.image = [UIImage imageNamed:@"source1N"];

    }else if(sender.tag == XSHouseSource_2){
        self.source0.image = [UIImage imageNamed:@"source0"];
        self.source1.image = [UIImage imageNamed:@"source1"];
    }
    self.resource = (XSHouseSource)sender.tag;
    [self resourceImage];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.resource = XSHouseSource_1;
    WEAK_SELF;
    self.searchView.searchBlack = ^(NSString *searhKey,XSBHouseType type) {
        STRONG_SELF;
         XSSearchEstateController *vc = [[XSSearchEstateController alloc]init];
          vc.cityModel = [XSUserServer sharedInstance].cityModel;
          vc.searchBlock = ^(XSHouseEsModel * _Nonnull model,XSBHouseType houseType) {
              XSHouselishViewController *list = [[XSHouselishViewController alloc]init];
              list.houseType = houseType;
              list.source = XSBHouseInfoSource_keyPush;
              list.resource = self.resource;
              list.esModel = model;
              [self.navigationController pushViewController:list animated:YES];
              
          };
          [self.navigationController pushViewController:vc animated:YES];
    };
    
    
    XSCollectionView *collectionView = [[XSCollectionView alloc]init];
    [self.searchCdView addSubview:collectionView];
    self.collectionView = collectionView;
    
    NSMutableArray *array = [self getDataWithJsonName:@"XSHouseSearch"];
    for (XSHouseModuleModel *model in array) {
        WEAK_SELF;
        model.clickBlack = ^(XSHouseModuleModel * _Nonnull model) {
            STRONG_SELF;
            if ([model.name isEqualToString:@"租房"]) {
                 XSHouselishViewController *list = [[XSHouselishViewController alloc]init];
                list.houseType = XSBHouseType_Rent;
                list.source = XSBHouseInfoSource_keyPush;
                list.resource = self.resource;
                list.module = YES;
                [self.navigationController pushViewController:list animated:YES];
            }else if ([model.name isEqualToString:@"新房"]){
                XSHouselishViewController *list = [[XSHouselishViewController alloc]init];
                list.houseType = XSBHouseType_New;
                list.source = XSBHouseInfoSource_keyPush;
                list.resource = self.resource;
                list.module = YES;
                [self.navigationController pushViewController:list animated:YES];
            }else if ([model.name isEqualToString:@"二手房"]){
                XSHouselishViewController *list = [[XSHouselishViewController alloc]init];
                 list.houseType = XSBHouseType_old;
                 list.source = XSBHouseInfoSource_keyPush;
                 list.resource = self.resource;
                 list.module = YES;
                 [self.navigationController pushViewController:list animated:YES];
            }
    
        };
    }
    self.array = array;

    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    self.categoryView.delegate = self;
    self.categoryView.titles = [self getTitlese];
    self.categoryView.titleFont = [UIFont systemFontOfSize:12];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelStrokeWidthEnabled = YES;
    self.categoryView.titleColor = [UIColor hx_colorWithHexStr:@"#929292"];
    self.categoryView.titleSelectedColor = [UIColor hx_colorWithHexStr:@"#E82B2B"];
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.backgroundColor = [UIColor clearColor];
    self.categoryView.listContainer = self.listContainerView;

    [self.changeTypeView addSubview:self.categoryView];
    [self.loveView addSubview:self.listContainerView];

    [self resourceImage];

}
- ( NSArray<NSString *>*)getTitlese{
    return @[@"二手房",@"新房",@"租房"];;
}
- (NSMutableArray<id<JXCategoryListContentViewDelegate>>*)listVc{
    if (!_listVc) {
        WEAK_SELF;
        _listVc = [NSMutableArray array];
        for (int i = 0; i < [self getTitlese].count; i++) {
            XSHouselishViewController *vc  = [[XSHouselishViewController alloc]init];
            vc.nubmer = 5;
            vc.source  = XSBHouseInfoSource_keyPush;
            vc.resource  = self.resource;
            vc.notHaveMenuView = YES;

            vc.callBackHeight = ^(CGFloat height) {
                STRONG_SELF;
                self.loveViewHeight.constant = height + 50;
                [self.view layoutIfNeeded];
            
            };
            if (i == 0) {
                vc.houseType  = XSBHouseType_old;
            }else if (i == 1){
                vc.houseType  = XSBHouseType_New;
            }else{
                vc.houseType  = XSBHouseType_Rent;
            }
            [_listVc addObject:vc];
        }
    }

    return _listVc;
}
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    
}
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.listVc.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [self.listVc safeObjectAtIndex:index];
}

- (void)resourceImage{
    for (XSHouseModuleModel *model in self.array) {
        model.tipImageName = self.resource ==XSHouseSource_1?@"source0image":@"source1image";
    }
    self.collectionView.array = self.array;

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searchView.frame = CGRectMake(0, 0, KScreenWidth, 220);
    self.collectionView.frame = self.searchCdView.bounds;
    self.categoryView.frame = self.changeTypeView.bounds;
    self.listContainerView.frame = self.loveView.bounds;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView.collectionView reloadData];
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}



- (NSMutableArray *)getDataWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:dataArray];
    return modelArray;
}
@end
