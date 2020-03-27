//
//  XSHouseRentInfoModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseRentInfoModel.h"


@implementation XSHouseRentInfoModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.dealStatus = self.dealStatus;
    one.totalFloor = self.totalFloor;
    one.estate = self.estate;
    one.title = self.title;
    one.watchNum = self.watchNum;
    one.formType = self.formType;
    one.orientationName = self.orientationName;
    one.status = self.status;
    one.updateDate = self.updateDate;
    one.firstImg = self.firstImg;
    one.latitude = self.latitude;
    one.customerId = self.customerId;
    one.dealStatusName = self.dealStatusName;
    one.house_id = self.house_id;
    one.cityId = self.cityId;
    one.orientation = self.orientation;
    one.longitude = self.longitude;
    one.rentPrice = self.rentPrice;
    one.distance = self.distance;
    one.featurePoints = self.featurePoints;
    one.area = self.area;
    one.statusName = self.statusName;
    one.formTypeOffice = self.formTypeOffice;
    one.formTypeRoom = self.formTypeRoom;
    one.floor = self.floor;
    return one;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"house_id":@"id"};
}
- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}


@end


