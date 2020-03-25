//
//  BRAddressModel.m
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 91renb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import "BRAddressModel.h"

@implementation BRProvinceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"code" : @"id",//前边的是你想用的key，后边的是返回的key
             @"name" : @"name",//前边的是你想用的key，后边的是返回的key
             @"citylist" : @"trees",//前边的是你想用的key，后边的是返回的key
             };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"citylist" : @"BRCityModel"};//前边，是属性数组的名字，后边就是类名
}
@end


@implementation BRCityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"code" : @"id",//前边的是你想用的key，后边的是返回的key
             @"name" : @"name",//前边的是你想用的key，后边的是返回的key
             @"arealist" : @"trees",//前边的是你想用的key，后边的是返回的key
             };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"arealist" : @"BRAreaModel"};//前边，是属性数组的名字，后边就是类名
}
@end


@implementation BRAreaModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"code" : @"id",//前边的是你想用的key，后边的是返回的key
             @"name" : @"name",//前边的是你想用的key，后边的是返回的key
             };
}
@end
