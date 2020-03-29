//
//  HomePageViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "HomePageViewController.h"
#import "XSLocationSearchview.h"
#import "XSHouseSubmitFirstViewController.h"

@interface HomePageViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) XSLocationSearchview *searchView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    XSLocationSearchview *searchView = [XSLocationSearchview locationSearchview];
    searchView.searchBlack = ^(NSString * _Nonnull searhKey) {
        NSLog(@"ss-%@",searhKey);
    };
    [self.titleView addSubview:searchView];
    self.searchView = searchView;
    XSUserModel *userModel = [[XSUserModel alloc]init];
    userModel.phone = @"15271323321";
    userModel.ID = [NSNumber numberWithInt:7];
    userModel.token = @"R90Gp4/kT2JQOnTzdc/ENU17U7HOI4fvS5XacHN6r9Jm/WVHYvKgeOO7EHxxT8my";
    [XSUserServer sharedInstance].userModel = userModel;
    
    [self city_tree];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searchView.frame = self.titleView.bounds;
}
- (IBAction)jumpClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
         
        }
        break;
        case 2:
        {
             
         }
        break;
        case 3:
        {
         
        }
        break;
        case 4:
        {
            XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
            
        default:
            break;
    }

}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

-(void)city_tree{
    
    WEAK_SELF;
    [self.subInfoInterface city_treeWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
//        STRONG_SELF;
//        [responseModel.data mj_JSONData];
//        [YBModelFile createFileWithName:@"XSCity" data:[responseModel.data mj_JSONData]];

        NSMutableArray *modelArray = [BRProvinceModel mj_objectArrayWithKeyValuesArray:responseModel.data];
  
        [XSHouseFixedData sharedInstance].cityArray = modelArray;
    }];
    
    [self.subInfoInterface bunnerListWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error==nil && responseModel.code.integerValue == SuccessCode) {
            
            
            NSMutableArray *modelArray = [XSHousePicture mj_objectArrayWithKeyValuesArray:responseModel.data];
            [XSHouseFixedData sharedInstance].bunnerArray = modelArray;
            
            self.searchView.imagePathsGroup = [XSHouseFixedData sharedInstance].bunnerUrlArray;
        }
    }];
    
    [self.subInfoInterface hotsSearchWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error==nil && responseModel.code.integerValue == SuccessCode) {
             
             
             NSMutableArray *modelArray = [XSHousehots mj_objectArrayWithKeyValuesArray:responseModel.data];
             [XSHouseFixedData sharedInstance].hotsSearchArray = modelArray;
             self.searchView.hotsSearchArray = [XSHouseFixedData sharedInstance].hotsSearchArray;
         }
    }];
}
@end
