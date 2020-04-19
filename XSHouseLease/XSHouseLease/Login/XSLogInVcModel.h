//
//  XSUserLogInModel.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/21.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,XSUserLogIStatus) {
    XSUserLogIStatus_MessageCheck = 0,
    XSUserLogIStatus_MessageAndPicyureCheck
};

@interface XSLogInVcModel : NSObject
// 电话
@property (nonatomic, copy) NSString *phone;
// 图像验证图
@property (nonatomic, strong) NSData *pictureData;
// 图像验证码
@property (nonatomic, copy) NSString *pictureCheckCode;
// 短信验证码
@property (nonatomic, copy) NSString *messageCheckCode;

// 是否同意用户协议
@property (nonatomic, assign) BOOL agreement;
// 是否可以发起登录
@property (nonatomic, assign) BOOL allowLogin;


// 是否可以点击获取短信验证码
@property (nonatomic, assign) BOOL allowMessage;
// 是否在等待接收短信中
@property (nonatomic, assign) BOOL waitingMessage;

@property (nonatomic, assign) XSUserLogIStatus logIStatus;
+ (BOOL)validateContactNumber:(NSString *)mobileNum;
@end

NS_ASSUME_NONNULL_END
