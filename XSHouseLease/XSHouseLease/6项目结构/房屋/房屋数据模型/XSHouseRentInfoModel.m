//
//  XSHouseRentInfoModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseRentInfoModel.h"

@implementation XSHouseDetailsFacilitiesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation XSHouseRentInfoModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.dealStatus = self.dealStatus;
      one.orientationName = self.orientationName;
      one.featurePoints = self.featurePoints;
      one.estateIntroduced = self.estateIntroduced;
      one.waterElectricity = self.waterElectricity;
      one.callPhone = self.callPhone;
      one.customerId = self.customerId;
      one.rentTimeTypeName = self.rentTimeTypeName;
      one.address = self.address;
      one.contentImg = self.contentImg;
      one.formTypeRoom = self.formTypeRoom;
      one.orientation = self.orientation;
      one.updateDate = self.updateDate;
      one.seeHouseTypeName = self.seeHouseTypeName;
      one.facilities = self.facilities;
      one.area = self.area;
      one.rentWayName = self.rentWayName;
      one.transportation = self.transportation;
      one.distance = self.distance;
      one.inDay = self.inDay;
      one.firstImg = self.firstImg;
      one.rentTimeType = self.rentTimeType;
      one.estate = self.estate;
      one.longitude = self.longitude;
      one.finishName = self.finishName;
      one.formTypeOffice = self.formTypeOffice;
      one.status = self.status;
      one.modelIntroduced = self.modelIntroduced;
      one.rentWay = self.rentWay;
      one.inDayName = self.inDayName;
      one.createDate = self.createDate;
      one.totalFloor = self.totalFloor;
      one.elevator = self.elevator;
      one.seeHouseType = self.seeHouseType;
      one.rentPrice = self.rentPrice;
      one.statusName = self.statusName;
      one.formType = self.formType;
      one.floor = self.floor;
      one.finish = self.finish;
      one.callName = self.callName;
      one.waterElectricityName = self.waterElectricityName;
      one.title = self.title;
      one.dealStatusName = self.dealStatusName;
      one.latitude = self.latitude;
    return one;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"house_id":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"facilities":@"XSHouseDetailsFacilitiesModel"};
}


- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}


@end


