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
    XShouseOperation_click = 0,//默认颜色
};
@class XSBHouseInfoModel;

// cell上面相关操作
typedef void(^HouseInfoClickBlack)(XSBHouseInfoModel *model,XShouseOperation operation);

// 房屋信息数据基类
@interface XSBHouseInfoModel : XSBaseObject
@property(nonatomic,copy) HouseInfoClickBlack clickBlack;

@property(nonatomic,copy) NSString *cellClass;

/*
area (number, optional),
cityId (integer, optional),
customerId (integer, optional),
dealStatus (integer, optional): 0未出租1是已出租 ,
dealStatusName (string, optional): 名字0未出租1是已出租 ,
distance (number, optional),
estate (string, optional): 小区名字 ,
featurePoints (Array[string], optional),
firstImg (string, optional): 第一张照片 ,
floor (integer, optional): 楼层 ,
formType (string, optional): 几室几厅 ,
formTypeOffice (integer, optional): 例如几室几厅的 厅 ,
formTypeRoom (integer, optional): 例如几室几厅的 室 ,
id (integer, optional),
latitude (number, optional),
longitude (number, optional),
orientation (integer, optional): 房子的朝向2朝南1朝东3朝西4朝北 ,
orientationName (string, optional): 房子的朝向2朝南1朝东3朝西4朝北 ,
rentPrice (number, optional): 租金 ,
status (integer, optional): 1待审核2审核失败3已取消4下架5暂停6发布 ,
statusName (string, optional): 名字1待审核2审核失败3已取消4下架5暂停6发布 ,
title (string, optional): 房子的朝向2朝南1朝东3朝西4朝北 ,
totalFloor (integer, optional): 总楼层 ,
updateDate (string, optional),
watchNum (integer, optional)
*/

@end

NS_ASSUME_NONNULL_END
