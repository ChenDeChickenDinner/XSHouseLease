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
typedef void(^searchBlock)(XSHouseEsModel *model,XSBHouseType houseType);

@interface XSSearchEstateController : XSBaseViewController
@property (nonatomic ,strong) BRProvinceModel *cityModel;
@property (nonatomic,copy)   searchBlock searchBlock;
@property(nonatomic,assign) XSBHouseType houseType;
@end

NS_ASSUME_NONNULL_END
