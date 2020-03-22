//
//  XSBaseViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "XSUserInfoInterface.h"


NS_ASSUME_NONNULL_BEGIN

@interface XSBaseViewController : UIViewController
@property (nonatomic, strong) AFHTTPSessionManager *operationManager;
@property (nonatomic,strong) XSUserInfoInterface *userInfoInterface;

- (void)refreshUIData;
@end

NS_ASSUME_NONNULL_END
