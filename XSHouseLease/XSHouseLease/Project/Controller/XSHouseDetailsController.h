//
//  XSHouseDetailsController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSHouseEnum.h"

@interface XSHouseDetailsController : XSBaseViewController
//展示类型租/新/二
@property(nonatomic,assign) XSBHouseType houseType;
//展示渠道来源 搜索/发布/关注/推送/猜你喜欢
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,copy) NSNumber *houseid;

@end


