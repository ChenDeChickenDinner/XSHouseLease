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
typedef NS_ENUM(NSInteger, XShouseOperation) {
    XShouseOperation_click = 0,//点击事件
};

typedef NS_ENUM(NSInteger,XSBHouseInfoSource) {
    XSBHouseInfoSource_Search = 0, // 搜索
    XSBHouseInfoSource_MyPublish, // 发布
    XSBHouseInfoSource_MyWatch , // 关注
    XSBHouseInfoSource_MyPush, // 推送，猜你喜欢

};
typedef NS_ENUM(NSInteger,XSBHouseType) {
    XSBHouseType_New = 0, // 新房
    XSBHouseType_old , // 二手房
    XSBHouseType_Rent  // 出租
};

@class XSBHouseInfoModel;

// cell上面相关操作
typedef void(^HouseInfoClickBlack)(XSBHouseInfoModel *model,XShouseOperation operation);

// 房屋信息数据基类
@interface XSBHouseInfoModel : XSBaseObject
@property(nonatomic,copy) HouseInfoClickBlack clickBlack;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;

@property(nonatomic,copy) NSString *cellClass;

@end

NS_ASSUME_NONNULL_END
