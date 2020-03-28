//
//  XSHouseRentInfoModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBHouseInfoModel.h"
#import "XSHouseRentInfoModel.h"

NS_ASSUME_NONNULL_BEGIN


// 配套设施
@interface XSHouseDetailsFacilitiesModel : NSObject

//
@property (nonatomic, strong) NSNumber *ID;
//
@property (nonatomic, copy) NSString *icon;
//
@property (nonatomic, copy) NSString *name;
//是否有
@property (nonatomic, assign) BOOL status;
//
@property (nonatomic, copy) NSString *createDate;

//
@property (nonatomic, copy) NSString *updateDate;
@end

@interface XSHouseRentInfoModel : XSBHouseInfoModel 


//标题
@property (nonatomic, copy) NSString *title;
////
//@property (nonatomic, strong) NSNumber *id;
//
@property (nonatomic, strong) NSNumber *house_id;

//属于哪个用户发布的
@property (nonatomic, strong) NSNumber *customerId;
@property (nonatomic, copy) NSString *callPhone;
@property (nonatomic, copy) NSString *callName;

//城市
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *city;
// 区
@property (nonatomic, copy) NSString *region;
// 镇
@property (nonatomic, copy) NSString *town;


//面积
@property (nonatomic, strong) NSNumber *area;
//小区名字
@property (nonatomic, copy) NSString *estate;
//河南省濮阳市清丰县六塔乡六塔集村
@property (nonatomic, copy) NSString *address;
//租金
@property (nonatomic, strong) NSNumber *rentPrice;

//经度
@property (nonatomic, strong) NSNumber *longitude;
// 维度
@property (nonatomic, strong) NSNumber *latitude;

//距离范围
@property (nonatomic, strong) NSNumber *distance;

//出租方式
@property (nonatomic, strong) NSNumber *rentWay;
//出租方式整租
@property (nonatomic, copy) NSString *rentWayName;

//封面图
@property (nonatomic, copy) NSString *firstImg;
//房屋图骗
@property (nonatomic, copy) NSArray<NSString *> *contentImg;

//例如几室几厅的 厅
@property (nonatomic, strong) NSNumber *formTypeOffice;
//例如几室几厅的 室
@property (nonatomic, strong) NSNumber *formTypeRoom;
// 几室几厅
@property (nonatomic, copy) NSString *formType;

// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, strong) NSNumber *orientation;
// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, copy) NSString *orientationName;


//楼层
@property (nonatomic, strong) NSNumber *floor;
//总楼层
@property (nonatomic, strong) NSNumber *totalFloor;


//看房方式 随时 约看
@property (nonatomic, strong) NSNumber *seeHouseType;
@property (nonatomic, copy) NSString *seeHouseTypeName;

//入住时间
@property (nonatomic, strong) NSNumber *inDay;
//入住时间 近20天内
@property (nonatomic, copy) NSString *inDayName;


//是否有电梯
@property (nonatomic, strong) NSNumber *elevator;

//水电类型
@property (nonatomic, strong) NSNumber *waterElectricity;
//水电类型
@property (nonatomic, copy) NSString *waterElectricityName;

// 0未出租1是已出租 ,
@property (nonatomic, strong) NSNumber *dealStatus;
// 名字0未出租1是已出租
@property (nonatomic, copy) NSString *dealStatusName;


//租期类型
@property (nonatomic, strong) NSNumber *rentTimeType;
//租期类型年租
@property (nonatomic, copy) NSString *rentTimeTypeName;

//装修类型
@property (nonatomic, strong) NSNumber *finish;
//装修类型
@property (nonatomic, copy) NSString *finishName;

//特色
@property (nonatomic, copy) NSArray<NSString *> *featurePoints;
//配套设施
@property (nonatomic, copy) NSArray<XSHouseDetailsFacilitiesModel *> *facilities;

//这是卖点
@property (nonatomic, copy) NSString *modelIntroduced;
//这是交通出行
@property (nonatomic, copy) NSString *transportation;
//这是小区介绍
@property (nonatomic, copy) NSString *estateIntroduced;


//发布状态
@property (nonatomic, strong) NSNumber *status;
//1待审核2审核失败3已取消4下架5暂停6发布
@property (nonatomic, copy) NSString *statusName;

//关注人数
@property (nonatomic, strong) NSNumber *watchNum;

//创建时间
@property (nonatomic, copy) NSString *createDate;

//更新日期
@property (nonatomic, copy) NSString *updateDate;












@end


NS_ASSUME_NONNULL_END
