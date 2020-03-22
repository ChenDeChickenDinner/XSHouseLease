//
//  XSUserLogInModel.m
//  XSHouseLease
//
//  Created by indulgeIn on 2020/03/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSUserLogInModel.h"


@implementation XSUserLogInModel
- (instancetype)init{
    if (self = [super init]) {
//        self.clientType = [NSNumber numberWithInt:2];
//        self.osInfo =  [[UIDevice currentDevice] systemVersion];
//        self.clientModel = [[UIDevice currentDevice] model];
//        self.clientBrand =  [[UIDevice currentDevice] name];

    }
    return self;
}
+ (instancetype)userLogInModelForVcModel:(XSLogInVcModel *)model{
    XSUserLogInModel *LogInModel = [[XSUserLogInModel alloc]init];
    LogInModel.phone = model.phone;
    LogInModel.authCode = model.messageCheckCode;
    LogInModel.pictureCode = model.pictureCheckCode;
    
//    LogInModel.phone = @"15271323321";
//    LogInModel.authCode = @"1234";
//
    return LogInModel;
}

@end


