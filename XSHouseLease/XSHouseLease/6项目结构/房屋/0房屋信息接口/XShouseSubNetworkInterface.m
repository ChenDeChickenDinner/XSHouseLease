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





// 搜索的租房信息-带搜索信息
- (void)searchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback{

//    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict safeSetObject:@"1" forKey:@"cityId"];

    NSString *url = [NSString stringWithFormat:@"%@/renthouse/page?per_page=%ld&page_index=%ld",XSBaseUrl,per_page,page_index];
    [self POST:url param:keyVales progress:nil callback:callback];
}

//我发布的租房
- (void)myPublishHosueWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
     NSString *customer_id = [XSUserServer sharedInstance].userModel.ID.stringValue;
     NSString *url = [NSString stringWithFormat:@"%@/renthouse/publish/page/%@?per_page=%ld&page_index=%ld",XSBaseUrl,customer_id,per_page,page_index];
     [self GET:url param:dict progress:nil callback:callback];
}


//我关注的租房
- (void)watchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback{
    NSString *customer_id = [XSUserServer sharedInstance].userModel.ID.stringValue;

//    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict safeSetObject:@"1" forKey:@"cityId"];

    NSString *url = [NSString stringWithFormat:@"%@/renthouse/watch/page/%@?per_page=%ld&page_index=%ld",XSBaseUrl,customer_id,per_page,page_index];
    [self POST:url param:keyVales progress:nil callback:callback];
}


//向我推荐的租房
- (void)watchlikeRenthousListWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback{
    NSString *customer_id = [XSUserServer sharedInstance].userModel.ID.stringValue;

    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict safeSetObject:@"1" forKey:@"cityId"];

    NSString *url = [NSString stringWithFormat:@"%@/renthouse/watchlike/page/%@?per_page=%ld&page_index=%ld",XSBaseUrl,customer_id,per_page,page_index];
    [self GET:url param:dict progress:nil callback:callback];
}



@end
