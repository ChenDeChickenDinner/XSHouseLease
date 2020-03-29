//
//  XSHouseFixedData.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/25.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseFixedData.h"
@implementation XSHousePicture
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
@implementation XSHousehots
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end



@implementation XSHouseFixedData

DEF_SINGLETON(XSHouseFixedData)

- (void)setBunnerArray:(NSMutableArray<XSHousePicture *> *)bunnerArray{
    _bunnerArray = bunnerArray;
    [_bunnerUrlArray removeAllObjects];
    for (XSHousePicture * pic in bunnerArray) {
        [_bunnerUrlArray addObject:pic.imgUrl.copy];
    }
  
}
- (NSMutableArray<NSString *> *)bunnerUrlArray{
    if (_bunnerUrlArray == nil) {
        _bunnerUrlArray = [NSMutableArray array];
    }
    return _bunnerUrlArray;
}

- (NSMutableDictionary *)subRentParameterDict{
    if (!_subRentParameterDict) {
        _subRentParameterDict = [NSMutableDictionary dictionary];
    }
    return _subRentParameterDict;
}
- (NSMutableArray<XSHouseModuleModel *> *)renthouseConditionArray{
    if (_renthouseConditionArray == nil) {
        _renthouseConditionArray = [NSMutableArray array];
    }
    return _renthouseConditionArray;
}
- (void)LocationParameterUpdateWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area{
    
   NSNumber *provinceValue = [NSNumber numberWithInteger:province.code.integerValue];
   NSNumber *cityValue = [NSNumber numberWithInteger:city.code.integerValue];
   NSNumber *areaValue = [NSNumber numberWithInteger:area.code.integerValue];

//   [self.subRentParameterDict safeSetObject:province.name forKey:@"city"];
//   [self.subRentParameterDict safeSetObject:provinceValue forKey:@"cityId"];
//   [self.subRentParameterDict safeSetObject:city.name forKey:@"region"];
//   [self.subRentParameterDict safeSetObject:cityValue forKey:@"regionId"];
//   [self.subRentParameterDict safeSetObject:area.name forKey:@"town"];
//   [self.subRentParameterDict safeSetObject:areaValue forKey:@"townId"];
    
    [self subRentParameterDictUpdateWithKey:@"city" value:province.name];
    [self subRentParameterDictUpdateWithKey:@"cityId" value:provinceValue];
    
    [self subRentParameterDictUpdateWithKey:@"region" value:city.name];
    [self subRentParameterDictUpdateWithKey:@"regionId" value:cityValue];
    
    [self subRentParameterDictUpdateWithKey:@"town" value:area.name];
    [self subRentParameterDictUpdateWithKey:@"townId" value:areaValue];

}

- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value{
    [self.subRentParameterDict safeSetObject:value forKey:key];
    NSLog(@"subRent = \n%@",self.subRentParameterDict);
}
@end
