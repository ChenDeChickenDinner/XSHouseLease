//
//  XSHouseRentInfoModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBHouseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XSHouseRentInfoModel : XSBHouseInfoModel 


//标题
@property (nonatomic, copy) NSString *title;

//
@property (nonatomic, strong) NSNumber *house_id;

//属于哪个用户发布的
@property (nonatomic, strong) NSNumber *customerId;

//城市
@property (nonatomic, strong) NSNumber *cityId;
//区域
@property (nonatomic, strong) NSNumber *area;
// 小区名字
@property (nonatomic, copy) NSString *estate;
//距离范围
@property (nonatomic, strong) NSNumber *distance;
//经度
@property (nonatomic, strong) NSNumber *longitude;
// 维度
@property (nonatomic, strong) NSNumber *latitude;



// 第一张照片
@property (nonatomic, copy) NSString *firstImg;

// 总楼层
@property (nonatomic, strong) NSNumber *totalFloor;
//楼层
@property (nonatomic, strong) NSNumber *floor;
//例如几室几厅的 厅
@property (nonatomic, strong) NSNumber *formTypeOffice;
//例如几室几厅的 室
@property (nonatomic, strong) NSNumber *formTypeRoom;
// 几室几厅
@property (nonatomic, copy) NSString *formType;
//租金
@property (nonatomic, strong) NSNumber *rentPrice;
//特色
@property (nonatomic, copy) NSArray<NSString *> *featurePoints;


// 0未出租1是已出租 ,
@property (nonatomic, strong) NSNumber *dealStatus;
// 名字0未出租1是已出租
@property (nonatomic, copy) NSString *dealStatusName;

// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, strong) NSNumber *orientation;
// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, copy) NSString *orientationName;


// 1待审核2审核失败3已取消4下架5暂停6发布
@property (nonatomic, strong) NSNumber *status;
//名字1待审核2审核失败3已取消4下架5暂停6发布
@property (nonatomic, copy) NSString *statusName;


//关注人数
@property (nonatomic, strong) NSNumber *watchNum;






//上传日期
@property (nonatomic, copy) NSString *updateDate;












@end


NS_ASSUME_NONNULL_END
