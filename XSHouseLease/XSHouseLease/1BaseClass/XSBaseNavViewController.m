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
   self.navigationBar.translucent = NO;
   self.navigationBar.barTintColor = [UIColor whiteColor];
//    [self.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}



/**
 *  通过拦截push方法来设置每个push进来的控制器的返回按钮
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0 ? YES : NO;
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"  " forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateHighlighted];

        [btn sizeToFit];
        // 让按钮内部的所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        //设置内边距，让按钮靠近屏幕边缘
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }

    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];

}


-(void)back
{

    [self popViewControllerAnimated:YES];
}



@end
