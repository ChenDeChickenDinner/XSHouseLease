//
//  XSMyPublishHosueController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSHouseRentInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSMyPublishHosueController : XSBaseViewController
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) BOOL alittle;

@property (nonatomic, strong) NSNumber *house_id;
@property(nonatomic,strong) NSMutableDictionary *searchDict;
- (void)loadData;
@end

NS_ASSUME_NONNULL_END
