//
//  XShouseSubNetworkInterface.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XShouseSubNetworkInterface.h"

@implementation XShouseSubNetworkInterface

// 上传房屋-入参信息相关枚举
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/enum/rentenums",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
// 城市信息-市区镇
- (void)city_treeWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/city/tree",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
//租房搜索条件-key
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/condition",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
// 租房上传提交
- (void)renthouseSaveWithDict:(NSDictionary *)dict callback:(HBCompletionBlock)callback{
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
}

// 上传图片
- (void)uploadImage:(UIImage *)image callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict safeSetObject:image forKey:@"file"];
    [dict safeSetObject:[XSUserServer sharedInstance].userModel.ID forKey:@"customerId"];
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
    
}


//- (void)renthousSearchListWithkeyDict:()image callback:(HBCompletionBlock)callback{
//
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict safeSetObject:image forKey:@"file"];
//    [dict safeSetObject:[XSUserServer sharedInstance].userModel.ID forKey:@"customerId"];
//    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
//    [self POST:url param:dict progress:nil callback:callback];
//}

@end
