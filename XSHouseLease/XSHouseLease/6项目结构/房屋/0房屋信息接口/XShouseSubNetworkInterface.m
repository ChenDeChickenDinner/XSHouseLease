//
//  XShouseSubNetworkInterface.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XShouseSubNetworkInterface.h"

@implementation XShouseSubNetworkInterface
//轮播图
- (void)bunnerListWithCallback:(HBCompletionBlock)callback{
NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
NSString *url = [NSString stringWithFormat:@"%@/bunner/list",XSBaseUrl];
[self GET:url param:dict progress:nil callback:callback];
    
}
- (void)hotsSearchWithCallback:(HBCompletionBlock)callback{
NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
NSString *url = [NSString stringWithFormat:@"%@/estate/hots",XSBaseUrl];
[self GET:url param:dict progress:nil callback:callback];
    
}

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
- (void)renthouseSaveWithDict:(NSMutableDictionary *)dict callback:(HBCompletionBlock)callback{
    NSNumber *customer_id = [XSUserServer sharedInstance].userModel.ID;
    [dict safeSetObject:customer_id forKey:@"customerId"];

    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"XSHouseSave" ofType:@"json"];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];



//    NSLog(@"jsonDict %@",jsonDict);
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/save2",XSBaseUrl];
    [self POST:url param:jsonDict progress:nil callback:callback];
//    [self POST:url param:dict progress:nil callback:callback];

}
// 上传图片
- (void)uploadImage:(UIImage *)image imageUrl:(NSURL *)imageUrl  callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict safeSetObject:[XSUserServer sharedInstance].userModel.ID forKey:@"customerId"];

    NSString *url = [NSString stringWithFormat:@"%@/file/image",XSBaseUrl];
    
    [self loadImageWithURL:url imageUrl:imageUrl param:dict progress:nil callback:callback];
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
- (void)watchlikeRenthousListWithhouse_id:(NSNumber *)house_id per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback{
//    NSString *customer_id = [XSUserServer sharedInstance].userModel.ID.stringValue;

    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict safeSetObject:@"1" forKey:@"cityId"];

    NSString *url = [NSString stringWithFormat:@"%@/renthouse/watchlike/page/%@?per_page=%ld&page_index=%ld",XSBaseUrl,house_id,per_page,page_index];
    [self GET:url param:dict progress:nil callback:callback];
}

    
- (void)renthouseDetailsWithHouse_id:(NSString *)house_id callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/renthouse/details",XSBaseUrl];
    if (house_id) {
        url = [url stringByAppendingFormat:@"/%@",house_id];
    }
    [self GET:url param:dict progress:nil callback:callback];

}
// 更变房子状态
- (void)editHouseStatusWithHouse_id:(NSNumber *)house_id houseType:(XSBHouseType)houseType status:(XSBHouseSubStatus)status  callback:(HBCompletionBlock)callback{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSNumber *customer_id = [XSUserServer sharedInstance].userModel.ID;
    NSString *url = [NSString stringWithFormat:@"%@/house/status",XSBaseUrl];
//
//    if (customer_id) {
//        url = [url stringByAppendingFormat:@"/%@",customer_id];
//    }
    if (house_id) {
        url = [url stringByAppendingFormat:@"/%@",house_id];
    }
    [dict safeSetObject:[NSString stringWithFormat:@"%ld",(long)houseType] forKey:@"type"];
//    [dict safeSetObject:[NSString stringWithFormat:@"%ld",(long)status] forKey:@"status"];
    [dict safeSetObject:[NSString stringWithFormat:@"1"] forKey:@"status"];

    [self GET:url param:dict progress:nil callback:callback];

}
// 关注取消关注房子
- (void)rentWatchHouseWithHouse_id:(NSString *)house_id houseType:(XSBHouseType)houseType watch:(BOOL)watch callback:(HBCompletionBlock)callback{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSNumber *customer_id = [XSUserServer sharedInstance].userModel.ID;
    NSString *url = [NSString stringWithFormat:@"%@/house/watch",XSBaseUrl];

    if (customer_id) {
        url = [url stringByAppendingFormat:@"/%@",customer_id];
    }
    if (house_id) {
        url = [url stringByAppendingFormat:@"/%@",house_id];
    }
    [dict safeSetObject:[NSString stringWithFormat:@"%ld",(long)houseType] forKey:@"type"];
    [dict safeSetObject:[NSNumber numberWithBool:watch] forKey:@"watch"];

    [self GET:url param:dict progress:nil callback:callback];

}

@end
