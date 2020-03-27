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
@end

NS_ASSUME_NONNULL_END
