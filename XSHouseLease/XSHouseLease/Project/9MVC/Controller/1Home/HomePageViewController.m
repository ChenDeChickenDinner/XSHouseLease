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

    [XSHouseSubMitDynamicServer sharedInstance];
    
    [XSUserServer automaticLogin];
    
    [self city_tree];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searchView.frame = self.titleView.bounds;
}
- (IBAction)jumpClick:(UIButton *)sender {
   
    [XSUserServer needLoginSuccess:^{
       switch (sender.tag) {
           case 0:
           case 1:
           {
               XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
               vc.submitType = (XSHouseSubmitType)sender.tag;
               [self.navigationController pushViewController:vc animated:YES];
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

               
           default:
               break;
       }
    } cancel:^{
        
    }];


}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

-(void)city_tree{
    WEAK_SELF;

    [[XSPublicServer sharedInstance] cityTreeWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        
    }];
    [[XSPublicServer sharedInstance] bunnerListWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
          self.searchView.imagePathsGroup = [XSPublicServer sharedInstance].bunnerUrlArray;

      }];
     [[XSPublicServer sharedInstance] hotsSearchWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;

          self.searchView.hotsSearchArray = [XSPublicServer sharedInstance].hotsSearchArray;

      }];

    [[XSPublicServer sharedInstance] enumFacilitiesWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
          
      }];
    [[XSPublicServer sharedInstance] renthouseConditionWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
          
      }];
}
@end
