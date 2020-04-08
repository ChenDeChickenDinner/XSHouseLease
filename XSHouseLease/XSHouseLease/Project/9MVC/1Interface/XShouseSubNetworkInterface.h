//
//  XShouseSubNetworkInterface.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSNetworkInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface XShouseSubNetworkInterface : XSNetworkInterface
// 城市信息-市区镇
- (void)city_treeWithCallback:(HBCompletionBlock)callback;

- (void)bunnerListWithCallback:(HBCompletionBlock)callbac;
// 上传房屋-入参信息相关枚举
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback;

// 租房上传提交
- (void)renthouseSaveWithDict:(NSMutableDictionary *)dict callback:(HBCompletionBlock)callback;

//租房搜索条件-key
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;


// 上传图片
- (void)uploadImage:(UIImage *)image imageUrl:(NSURL *)imageUrl callback:(HBCompletionBlock)callback;

// 搜索的租房信息-带搜索信息
- (void)searchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//我发布的租房
- (void)myPublishHosueWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//我关注的租房
- (void)watchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//向我推荐的租房
- (void)watchlikeRenthousListWithhouse_id:(NSNumber *)house_id per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

// 租房详情
- (void)renthouseDetailsWithHouse_id:(NSString *)house_id callback:(HBCompletionBlock)callback;

//热搜
- (void)hotsSearchWithCallback:(HBCompletionBlock)callback;

// 更变房子状态
- (void)editHouseStatusWithHouse_id:(NSString *)house_id houseType:(XSBHouseType)houseType status:(XSBHouseSubStatus)status  callback:(HBCompletionBlock)callback;

// 关注取消关注房子
- (void)rentWatchHouseWithHouse_id:(NSString *)house_id houseType:(XSBHouseType)houseType watch:(BOOL)watch callback:(HBCompletionBlock)callback;
@end

NS_ASSUME_NONNULL_END
