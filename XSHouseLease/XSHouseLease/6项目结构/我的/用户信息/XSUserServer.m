//
//  XSUserServer.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSUserServer.h"

NSString *const HBNotificationLoginStatusChangedLoginFailed = @"HBNotificationLoginStatusChangedLoginFailed";

NSString *const NotificationLoginStatusChangedLogin = @"NotificationLoginStatusChangedLogin";

NSString *const NotificationLoginStatusChangedLogout = @"NotificationLoginStatusChangedLogout";

@implementation XSUserServer
DEF_SINGLETON(XSUserServer)

- (void)setUserModel:(XSUserModel *)userModel{
    _userModel = userModel;
    NSLog(@"userModel = %@",[userModel mj_keyValues]);
}
- (BRProvinceModel *)cityModel{
    if (_cityModel == nil) {
        _cityModel = [[BRProvinceModel alloc]init];
        _cityModel.code = @"1";
        _cityModel.name = @"上海";
    }
    return _cityModel;
}
@end
