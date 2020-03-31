//
//  XSBHouseInfoModel.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"

NS_ASSUME_NONNULL_BEGIN


// SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组];


@class XSBHouseInfoModel;

// cell上面相关操作
typedef void(^HouseInfoClickBlack)(XSBHouseInfoModel *model,XShouseOperation operation);

// 房屋信息数据基类
@interface XSBHouseInfoModel : XSBaseObject
@property(nonatomic,copy) HouseInfoClickBlack clickBlack;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,copy) NSString *cellClass;
//@property(nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,copy) clickEditStatus clickEditStatu;
@property (nonatomic,copy) valuechangeStatus valuechangeStatus;



@end

NS_ASSUME_NONNULL_END
