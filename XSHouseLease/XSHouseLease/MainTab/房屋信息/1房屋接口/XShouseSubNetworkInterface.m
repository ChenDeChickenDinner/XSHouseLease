//
//  XShouseSubNetworkInterface.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XShouseSubNetworkInterface.h"

@implementation XShouseSubNetworkInterface
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/enum/rentenums",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
- (void)city_treeWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/city/tree",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/condition",XSBaseUrl];
    [self GET:url param:dict progress:nil callback:callback];

}
- (void)renthouseSaveWithDict:(NSDictionary *)dict callback:(HBCompletionBlock)callback{
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
}


- (void)uploadImage:(UIImage *)image callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict safeSetObject:image forKey:@"file"];
    [dict safeSetObject:[XSUserServer sharedInstance].userModel.ID forKey:@"customerId"];
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
}

@end
