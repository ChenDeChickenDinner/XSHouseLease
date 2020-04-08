//
//  XSBHouseInfoModel.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSHouseEnum.h"
#import "XSHouseBlock.h"
NS_ASSUME_NONNULL_BEGIN




@class XSBHouseInfoModel;

// cell上面相关操作
typedef void(^HouseInfoClickBlack)(XSBHouseInfoModel *model,XShouseOperation operation);

// 房屋信息数据基类
@interface XSBHouseInfoModel : XSBaseObject

@property(nonatomic,copy) HouseInfoClickBlack clickBlack;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,copy) NSString *cellClass;
@property (nonatomic,copy) clickEditStatus clickEditStatu;
@property (nonatomic,copy) XSValuechangeStatus valuechangeStatus;



@end

NS_ASSUME_NONNULL_END
