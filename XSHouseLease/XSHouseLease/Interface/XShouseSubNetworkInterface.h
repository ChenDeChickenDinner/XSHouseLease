//
//  XShouseSubNetworkInterface.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSNetworkInterface.h"
#import "XSHouseEnum.h"

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
// 小区查询
- (void)searchEstateWithDict:(NSDictionary *)dict callback:(HBCompletionBlock)callback;

// 配套
- (void)enumFacilitiesWithCallback:(HBCompletionBlock)callback;

// 租房上传-动态入参获取
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback;


// 二手房上传-动态入参获取
- (void)getSellEnumsWithCallback:(HBCompletionBlock)callback;

// 租房上传提交
- (void)renthouseSaveWithDict:(NSMutableDictionary *)dict houseType:(XSBHouseType)houseType callback:(HBCompletionBlock)callback;


- (void)houseLisetWith:(XSBHouseType)houseType source:(XSBHouseInfoSource)source house_id:(NSString *)house_id KeyVales:(NSMutableDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

// 房详情
- (void)houseDetailsWithHouseType:(XSBHouseType)houseType house_id:(NSNumber *)house_id callback:(HBCompletionBlock)callback;




// 更变房子状态
- (void)editHouseStatusWithHouse_id:(NSNumber *)house_id houseType:(XSBHouseType)houseType status:(XSBHouseSubStatus)status  callback:(HBCompletionBlock)callback;
// 关注取消关注房子
- (void)rentWatchHouseWithHouse_id:(NSNumber *)house_id houseType:(XSBHouseType)houseType watch:(BOOL)watch callback:(HBCompletionBlock)callback;



//租房搜索条件-key
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;

@end

NS_ASSUME_NONNULL_END
