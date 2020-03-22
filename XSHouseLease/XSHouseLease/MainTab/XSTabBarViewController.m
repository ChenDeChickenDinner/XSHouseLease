//
//  XSTabBarViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSTabBarViewController.h"

#import "XSBaseNavViewController.h"
#import "HomePageViewController.h"
#import "FindHouseViewController.h"
#import "MyInfoViewController.h"
#import "MessageViewController.h"
#import "XSBaseObject.h"

@interface XSTabBarViewController ()

@end

@implementation XSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    HomePageViewController *HomePage =  [[HomePageViewController alloc]init];
    FindHouseViewController *find =  [[FindHouseViewController alloc]init];
    MessageViewController *message =  [[MessageViewController alloc]init];
    MyInfoViewController *myinfo =  [[MyInfoViewController alloc]init];
    [self addChildVc:HomePage title:@"首页" image:nil selectedImage:nil];
    [self addChildVc:find title:@"查找" image:nil selectedImage:nil];
    [self addChildVc:message title:@"消息" image:nil selectedImage:nil];
    [self addChildVc:myinfo title:@"我的" image:nil selectedImage:nil];

}
- (void)YBMFConfig{
  
    

}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    XSBaseNavViewController *nav = [[XSBaseNavViewController alloc] initWithRootViewController:childVc];
    nav.tabBarItem.title = title;
//    [nav.tabBarItem setImage:[UIImage imageNamed:image]];
//    [nav.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    [self addChildViewController:nav];
    
}
@end
