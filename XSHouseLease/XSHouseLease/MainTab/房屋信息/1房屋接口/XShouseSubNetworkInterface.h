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
// 获取房屋信息相关枚举
- (void)getRentEnumsWithCallback:(HBCompletionBlock)callback;
- (void)city_treeWithCallback:(HBCompletionBlock)callback;
- (void)renthouseSaveWithDict:(NSDictionary *)dict callback:(HBCompletionBlock)callback;
//租房导航
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;
- (void)uploadImage:(UIImage *)image callback:(HBCompletionBlock)callback;
@end

NS_ASSUME_NONNULL_END
