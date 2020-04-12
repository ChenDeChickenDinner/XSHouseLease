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
            if ([model.name isEqualToString:@"租房"]) {
                XSHouseModuleViewController *vc = [[XSHouseModuleViewController alloc]init];
                vc.houseType = XSBHouseType_Rent;
                vc.source = XSBHouseInfoSource_keyPush;
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([model.name isEqualToString:@"新房"]){
                XSHouseModuleViewController *vc = [[XSHouseModuleViewController alloc]init];
               vc.houseType = XSBHouseType_New;
               vc.source = XSBHouseInfoSource_keyPush;
               [self.navigationController pushViewController:vc animated:YES];
            }else if ([model.name isEqualToString:@"二手房"]){
                XSHouseModuleViewController *vc = [[XSHouseModuleViewController alloc]init];
               vc.houseType = XSBHouseType_old;
               vc.source = XSBHouseInfoSource_keyPush;
               [self.navigationController pushViewController:vc animated:YES];
            }
    
        };
    }
    self.collectionView.array = array;
    XSLocationSearchview *searchView = [XSLocationSearchview locationSearchview];
    searchView.searchBlack = ^(NSString * _Nonnull searhKey) {
        NSLog(@"ss-%@",searhKey);
    };
    [self.view addSubview:searchView];
    self.searchView = searchView;
    

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



- (NSMutableArray *)getDataWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:dataArray];
    return modelArray;
}
@end
