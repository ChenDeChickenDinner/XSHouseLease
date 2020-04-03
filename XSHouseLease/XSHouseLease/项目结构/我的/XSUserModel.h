//
//  XSUserModel.h
//  XSHouseLease
//
//  Created by indulgeIn on 2020/03/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSBaseObject.h"

NS_ASSUME_NONNULL_BEGIN



@interface XSUserModel : XSBaseObject


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


NS_ASSUME_NONNULL_END
