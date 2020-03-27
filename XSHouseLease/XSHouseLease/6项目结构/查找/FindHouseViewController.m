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

@interface FindHouseViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) XSLocationSearchview *searchView;
@property (weak, nonatomic) XSCollectionView *collectionView;

@end

@implementation FindHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    XSCollectionView *collectionView = [[XSCollectionView alloc]init];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    NSMutableArray *array = [self getDataWithJsonName:@"XSHouseSearch"];
    for (XSHouseModuleModel *model in array) {
        WEAK_SELF;
        model.clickBlack = ^(XSHouseModuleModel * _Nonnull model) {
            STRONG_SELF;
            XSHouseModuleViewController *vc = [[XSHouseModuleViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    self.collectionView.array = array;
    XSLocationSearchview *searchView = [XSLocationSearchview locationSearchview];
    [self.view addSubview:searchView];
    self.searchView = searchView;
    
    [self renthouseConditionWithCallback];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searchView.frame = CGRectMake(0, 0, self.view.width, 220);
    self.collectionView.frame = CGRectMake(0, 220, self.view.width, 230);

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

-(void)renthouseConditionWithCallback{
    
    [self.subInfoInterface renthouseConditionWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:responseModel.data];
        [XSHouseFixedData sharedInstance].renthouseConditionArray = modelArray;
    }];
}


- (NSMutableArray *)getDataWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:dataArray];
    return modelArray;
}
@end
