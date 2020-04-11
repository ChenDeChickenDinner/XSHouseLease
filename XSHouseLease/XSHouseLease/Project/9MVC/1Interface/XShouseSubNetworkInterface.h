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
/// 上传图片
- (void)uploadImage:(UIImage *)image imageUrl:(NSURL *)imageUrl  callback:(HBCompletionBlock)callback;

// 城市信息-市区镇
- (void)city_treeWithCallback:(HBCompletionBlock)callback;

//轮播图
- (void)bunnerListWithCallback:(HBCompletionBlock)callback;

// 热搜
- (void)hotsSearchWithCallback:(HBCompletionBlock)callback;
// 配套
- (void)enumFacilitiesWithCallback:(HBCompletionBlock)callback;

// 租房上传-动态入参获取
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback;


// 二手房上传-动态入参获取
- (void)getSellEnumsWithCallback:(HBCompletionBlock)callback;

// 租房上传提交
- (void)renthouseSaveWithDict:(NSMutableDictionary *)dict callback:(HBCompletionBlock)callback;


// 二手房上传提交
- (void)secondhouseSaveWithDict:(NSMutableDictionary *)dict callback:(HBCompletionBlock)callback;

// 租房详情
- (void)renthouseDetailsWithHouse_id:(NSString *)house_id callback:(HBCompletionBlock)callback;
// 二手房详情
- (void)secondhouseDetailsWithHouse_id:(NSString *)house_id callback:(HBCompletionBlock)callback;

// 新房详情
- (void)newhouseDetailsWithHouse_id:(NSString *)house_id callback:(HBCompletionBlock)callback;

//我发布的租房
- (void)myPublishHosueWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//我发布的二手房
- (void)myPublishSecondHouseWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;



//我关注的租房
- (void)watchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//我关注的二手房
- (void)watchSecondHouseListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//我关注的新房
- (void)watchNewHouseListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

// 根据-城市-推荐列表(租房)
- (void)searchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//根据-房屋详情的-推荐列表(租房)
- (void)likeRenthousListWithhouse_id:(NSNumber *)house_id per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//根据-我关注的-推荐列表(租房)
- (void)watchlikeRenthousListWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
// 根据-城市-推荐列表(二手房)
- (void)searchSecondhousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//根据-房屋详情的-推荐列表(二手房)
- (void)likeSecondhousListWithhouse_id:(NSNumber *)house_id per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//根据-我关注的-推荐列表(二手房)
- (void)watchlikeSecondhousListWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;


// 根据-城市-推荐列表(新房)
- (void)searchNewhousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//根据-房屋详情的-推荐列表(新房)
- (void)likeNewhousListWithhouse_id:(NSNumber *)house_id per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//根据-我关注的-推荐列表(新房)
- (void)watchlikeNewhousListWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
    




// 更变房子状态
- (void)editHouseStatusWithHouse_id:(NSNumber *)house_id houseType:(XSBHouseType)houseType status:(XSBHouseSubStatus)status  callback:(HBCompletionBlock)callback;
// 关注取消关注房子
- (void)rentWatchHouseWithHouse_id:(NSString *)house_id houseType:(XSBHouseType)houseType watch:(BOOL)watch callback:(HBCompletionBlock)callback;



//租房搜索条件-key
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;

@end

NS_ASSUME_NONNULL_END
