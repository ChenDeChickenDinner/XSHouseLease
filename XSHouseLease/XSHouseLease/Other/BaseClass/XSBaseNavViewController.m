//
//  XSBaseNavViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseNavViewController.h"

@interface XSBaseNavViewController ()

@end

@implementation XSBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0 ? YES : NO;
    [super pushViewController:viewController animated:animated];
 
}


@end
