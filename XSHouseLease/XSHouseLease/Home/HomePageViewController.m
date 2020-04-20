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
#import "XSResourceViewController.h"

@interface HomePageViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) XSLocationSearchview *searchView;
@property (weak, nonatomic) IBOutlet UIImageView *source0;
@property (weak, nonatomic) IBOutlet UIImageView *source1;

@property (weak, nonatomic) IBOutlet UIImageView *tisImage1;
@property (weak, nonatomic) IBOutlet UIImageView *tisImage2;
@property (weak, nonatomic) IBOutlet UIImageView *tisImage3;
@property (weak, nonatomic) IBOutlet UIImageView *tisImage4;

@property (nonatomic,assign) XSHouseSource resource;
@end

@implementation HomePageViewController
- (IBAction)source:(UIButton *)sender {

    if (sender.tag == XSHouseSource_1) {
        self.source0.image = [UIImage imageNamed:@"source0S"];
        self.source1.image = [UIImage imageNamed:@"source1N"];
        self.tisImage1.image = [UIImage imageNamed:@"source0image"];
        self.tisImage2.image = [UIImage imageNamed:@"source0image"];
        self.tisImage3.image = [UIImage imageNamed:@"source0image"];
        self.tisImage4.image = [UIImage imageNamed:@"source0image"];
    }else if(sender.tag == XSHouseSource_2){
        self.source0.image = [UIImage imageNamed:@"source0"];
        self.source1.image = [UIImage imageNamed:@"source1"];
        self.tisImage1.image = [UIImage imageNamed:@"source1image"];
        self.tisImage2.image = [UIImage imageNamed:@"source1image"];
        self.tisImage3.image = [UIImage imageNamed:@"source1image"];
        self.tisImage4.image = [UIImage imageNamed:@"source1image"];
    }
    self.resource = (XSHouseSource)sender.tag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.resource = XSHouseSource_1;
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
- (void)agencyChicken:(void(^)(void))success{
    XSResourceViewController *vc = [[XSResourceViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
     return;
    
    if (self.resource == XSHouseSource_2) {
        if (![XSUserServer sharedInstance].userModel.agency) {
            XSResourceViewController *vc = [[XSResourceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    if (success) {
        success();
    }
}
- (IBAction)jumpClick:(UIButton *)sender {


    [XSUserServer needLoginSuccess:^{
       switch (sender.tag) {
           case 0:
           {
               [self agencyChicken:^{
                   XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
                   vc.houseType = XSBHouseType_Rent;
                   vc.resource = self.resource;
                   [self.navigationController pushViewController:vc animated:YES];
               }];

           }
               break;
           case 1:
           {
               [self agencyChicken:^{
                  XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
                  vc.houseType = XSBHouseType_old;
                  vc.resource = self.resource;
                  [self.navigationController pushViewController:vc animated:YES];
                }];

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
