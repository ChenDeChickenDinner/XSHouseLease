//
//  XSTabBarViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSTabBarViewController.h"

#import "HomePageViewController.h"
#import "FindHouseViewController.h"
#import "MyInfoViewController.h"
#import "XSMessageViewController.h"
#import <Foundation/Foundation.h>
#import "XSNavViewController.h"

@interface XSTabBarViewController ()

@end

@implementation XSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    HomePageViewController *HomePage =  [[HomePageViewController alloc]init];
    FindHouseViewController *find =  [[FindHouseViewController alloc]init];
    XSMessageViewController *message =  [[XSMessageViewController alloc]init];
    MyInfoViewController *myinfo =  [[MyInfoViewController alloc]init];
    [self addChildVc:HomePage title:@"首页" image:@"pageN" selectedImage:@"pageS"];
    [self addChildVc:find title:@"查找" image:@"findN" selectedImage:@"findS"];
    [self addChildVc:message title:@"消息" image:@"messageN" selectedImage:@"messageS"];
    [self addChildVc:myinfo title:@"我的" image:@"myN" selectedImage:@"myS"];

}
- (void)YBMFConfig{
  
    

}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
  
    XSNavViewController *nav = [[XSNavViewController alloc] initWithRootViewController:childVc];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setImage:[UIImage imageNamed:image]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    [self addChildViewController:nav];

}
@end
