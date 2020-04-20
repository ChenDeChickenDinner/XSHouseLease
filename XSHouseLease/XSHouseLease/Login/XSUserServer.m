//
//  XSUserServer.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSUserServer.h"
#import "XSLoginViewController.h"

NSString *const HBNotificationLoginStatusChangedLoginFailed = @"HBNotificationLoginStatusChangedLoginFailed";

NSString *const NotificationLoginStatusChangedLogin = @"NotificationLoginStatusChangedLogin";

NSString *const NotificationLoginStatusChangedLogout = @"NotificationLoginStatusChangedLogout";
@implementation XSUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",//前边的是你想用的key，后边的是返回的key
             };
}
@end



@implementation XSUserServer
DEF_SINGLETON(XSUserServer)
+ (void)automaticLogin{
     NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
     XSUserModel *model =  [XSUserModel mj_objectWithKeyValues:userInfo];
    NSLog(@"userinfo:%@",userInfo);
    if (model.token) {
        [XSUserServer sharedInstance].userModel = model;
    }
}
- (void)setUserModel:(XSUserModel *)userModel{
    _userModel = userModel;
    if (_userModel.token) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStatusChangedLogin object:nil];
    }

    NSLog(@"userModel = %@",[userModel mj_keyValues]);
}
- (BOOL)isLogin{
    if (_userModel.token) {
        return YES;
    }
    return NO;
}
- (BRProvinceModel *)cityModel{
    if (_cityModel == nil) {
        _cityModel = [[BRProvinceModel alloc]init];
        _cityModel.code = @"1";
        _cityModel.name = @"上海";
    }
    return _cityModel;
}

+ (void)needLoginSuccess:(logSuccess)successBlack cancel:(logCancel)cancelBlack{
    if (successBlack) {
            successBlack();
        }
    return;
    if (![XSUserServer sharedInstance].isLogin) {
         XSLoginViewController *login = [[XSLoginViewController alloc]init];
        login.successBlack = successBlack;
        login.cancelBlack = cancelBlack;
         login.modalPresentationStyle = UIModalPresentationFullScreen;
         [[NSObject getTopViewController] presentViewController:login animated:YES completion:^{
             
         }];
    }else{
        if (successBlack) {
            successBlack();
        }
    }
  
}
@end
