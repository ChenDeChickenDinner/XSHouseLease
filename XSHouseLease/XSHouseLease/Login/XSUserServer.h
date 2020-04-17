//
//  XSUserServer.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BRAddressModel.h"
#import "XSHouseEnum.h"


UIKIT_EXTERN NSString *const HBNotificationLoginStatusChangedLoginFailed;
UIKIT_EXTERN NSString *const NotificationLoginStatusChangedLogin;
UIKIT_EXTERN NSString *const NotificationLoginStatusChangedLogout;

#define Login [HBUserServer sharedInstance].isLogin


@interface XSUserModel : NSObject


//
@property (nonatomic, strong) NSNumber *ID;

//
@property (nonatomic, copy) NSString *name;

//
@property (nonatomic, copy) NSString *nickName;

//
@property (nonatomic, copy) NSString *icon;

//
@property (nonatomic, assign) BOOL vip;

//
@property (nonatomic, copy) NSString *token;

//
@property (nonatomic, assign) BOOL activate;

//
@property (nonatomic, copy) NSString *phone;

//
@property (nonatomic, copy) NSString *expirationDate;

//
@property (nonatomic, copy) NSString *city;

@end

@interface XSUserServer : NSObject

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


