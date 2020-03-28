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

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"facilities" : @"XSHouseDetailsFacilitiesModel"};//前边，是属性数组的名字，后边就是类名
}
- (NSArray *)getAllProperties{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++){
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;

}



//Model 到字典

- (NSDictionary *)properties_aps{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}


@end


