//
//  XSMyPublishHosueController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSBHouseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSMyPublishHosueController : XSBaseViewController
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;

@property(nonatomic,strong) NSMutableDictionary *searchDict;

@end

NS_ASSUME_NONNULL_END
