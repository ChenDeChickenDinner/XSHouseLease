//
//  XSSearchEstateController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/4/12.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^searchBlock)(XSHouseEsModel *model);

@interface XSSearchEstateController : XSBaseViewController
@property (nonatomic,strong) NSMutableDictionary *dict;
@property (nonatomic,copy)   searchBlock searchBlock;
@end

NS_ASSUME_NONNULL_END
