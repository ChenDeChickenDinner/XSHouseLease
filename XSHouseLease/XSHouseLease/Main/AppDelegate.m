//
//  AppDelegate.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "AppDelegate.h"
#import "XSTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.rootViewController = [[XSTabBarViewController alloc]init];
     [self.window makeKeyAndVisible];
    [AMapServices sharedServices].apiKey = @"9130b0a7ff0c9fd01b8d91eca03acb36";
    return YES;
}





@end
