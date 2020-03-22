//
//  XSOperationParam.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XSOperationParam : NSObject
@property(nonatomic,assign) BOOL isLooding;

/** 是否允许打印接口日志，默认为YES */
@property (nonatomic, assign) BOOL enableInterfaceLog;
/** 是否允许错误提示，默认为YES */
@property (nonatomic, assign) BOOL enableErrorPrompt;
/** 重试次数，默认为1 */
@property (nonatomic, assign) NSInteger retryTimes;
/** 超时时间，默认为30s */
@property (nonatomic, assign) NSTimeInterval timeoutTime;

@end

NS_ASSUME_NONNULL_END
