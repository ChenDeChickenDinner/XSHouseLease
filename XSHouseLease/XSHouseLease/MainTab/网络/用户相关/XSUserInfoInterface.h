//
//  XSUserInfoInterface.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSNetworkInterface.h"

NS_ASSUME_NONNULL_BEGIN
@class XSUserLogInModel;
@interface XSUserInfoInterface : XSNetworkInterface
- (void)sendmessageWithPhone:(NSString *)phone pictureCode:(NSString *)pictureCode callback:(HBCompletionBlock)callback;

- (void)sendpictureWithPhone:(NSString *)phone  callback:(HBCompletionBlock)callback;

- (void)loginWithCheckInfo:(XSUserLogInModel *)info callback:(HBCompletionBlock)callback;

@end

NS_ASSUME_NONNULL_END
