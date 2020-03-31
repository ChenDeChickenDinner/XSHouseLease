//
//  XSUserServer.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSUserModel.h"
#import "BRAddressModel.h"

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString *const HBNotificationLoginStatusChangedLoginFailed;
UIKIT_EXTERN NSString *const NotificationLoginStatusChangedLogin;
UIKIT_EXTERN NSString *const NotificationLoginStatusChangedLogout;
#define Login [HBUserServer sharedInstance].isLogin

@interface XSUserServer : XSBaseObject

//AS_SINGLETON(XSUserServer)
+ (XSUserServer *)sharedInstance;

+ (void)automaticLogin;
/** 用户模型 */
@property (nonatomic ,strong) XSUserModel *userModel;

@property (nonatomic ,strong) BRProvinceModel *cityModel;


/** 是否登录 */
@property (nonatomic ,assign) BOOL isLogin;

+ (void)needLoginSuccess:(logSuccess)successBlack cancel:(logCancel)cancelBlack;
@end

NS_ASSUME_NONNULL_END
