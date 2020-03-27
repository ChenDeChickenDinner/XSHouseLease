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
    [self.titleView addSubview:searchView];
    self.searchView = searchView;
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searchView.frame = self.titleView.bounds;
}
- (IBAction)jumpClick:(UIButton *)sender {
    XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
@end
