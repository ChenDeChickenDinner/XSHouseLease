//
//  XSBusinessInfoSever.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBusinessInfoSever.h"

@implementation XSHouseFixedData

DEF_SINGLETON(XSHouseFixedData)



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

    [self subRentParameterDictUpdateWithKey:@"city" value:province.name];
    [self subRentParameterDictUpdateWithKey:@"cityId" value:provinceValue];
    
    [self subRentParameterDictUpdateWithKey:@"region" value:city.name];
    [self subRentParameterDictUpdateWithKey:@"regionId" value:cityValue];
    
    [self subRentParameterDictUpdateWithKey:@"town" value:area.name];
    [self subRentParameterDictUpdateWithKey:@"townId" value:areaValue];

    

}

- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value{
    [self.subRentParameterDict safeSetObject:value forKey:key];
//    NSLog(@"subRent = \n%@",self.subRentParameterDict);
}
@end
