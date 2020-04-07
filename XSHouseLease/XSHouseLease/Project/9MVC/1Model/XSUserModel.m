//
//  XSUserModel.m
//  XSHouseLease
//
//  Created by indulgeIn on 2020/03/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSUserModel.h"


@implementation XSUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",//前边的是你想用的key，后边的是返回的key
             };
}
@end


