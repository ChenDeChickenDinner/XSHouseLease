//
//  XSUserLogInModel.h
//  XSHouseLease
//
//  Created by indulgeIn on 2020/03/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSLogInVcModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XSUserLogInModel : XSBaseObject
//登录手机号
@property (nonatomic, copy) NSString *phone;

//短信验证码
@property (nonatomic, copy) NSString *authCode;

//图形验证码
@property (nonatomic, copy) NSString *pictureCode;

//客户端1是android 2是ios 3 小程序 ,
@property (nonatomic, strong) NSNumber *clientType;

//用户client版本号
@property (nonatomic, copy) NSString *clientVersion;

//手机系统信息
@property (nonatomic, copy) NSString *osInfo;

//客户端品牌
@property (nonatomic, copy) NSString *clientBrand;

//设备型号
@property (nonatomic, copy) NSString *clientModel;

// 根据登录界面模型
+ (instancetype)userLogInModelForVcModel:(XSLogInVcModel *)model;

@end


NS_ASSUME_NONNULL_END
