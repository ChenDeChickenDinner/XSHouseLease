//
//  XSHouseBlock.h
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//
#import "XSHouseEnum.h"

//登录业务
typedef void(^logSuccess)(void);
typedef void(^logCancel)(void);
//搜索完成回调
typedef void(^searchBlack)(NSString *searhKey);
//更改房屋状态
typedef void(^clickEditStatus)(NSNumber *status,NSNumber *houseID);

//value发生编辑
typedef void(^XSValuechangeStatus)(NSString *key,XSBHouseKeyValueEditStatus editStatus);



