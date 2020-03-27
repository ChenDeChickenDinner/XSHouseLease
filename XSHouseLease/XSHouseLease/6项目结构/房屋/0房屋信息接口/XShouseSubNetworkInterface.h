//
//  XShouseSubNetworkInterface.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSNetworkInterface.h"
#import "XSHouseSubAllMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface XShouseSubNetworkInterface : XSNetworkInterface
// 城市信息-市区镇
- (void)city_treeWithCallback:(HBCompletionBlock)callback;

// 上传房屋-入参信息相关枚举
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback;

// 租房上传提交
- (void)renthouseSaveWithDict:(NSDictionary *)dict callback:(HBCompletionBlock)callback;

//租房搜索条件-key
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;

// 上传图片
- (void)uploadImage:(UIImage *)image callback:(HBCompletionBlock)callback;
// 搜索的租房信息-带搜索信息
- (void)searchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
//我发布的租房
- (void)myPublishHosueWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//我关注的租房
- (void)watchRenthousListWithKeyVales:(NSDictionary *)keyVales per_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;

//向我推荐的租房
- (void)watchlikeRenthousListWithPer_page:(NSInteger)per_page page_index:(NSInteger)page_index  callback:(HBCompletionBlock)callback;
@end

NS_ASSUME_NONNULL_END
