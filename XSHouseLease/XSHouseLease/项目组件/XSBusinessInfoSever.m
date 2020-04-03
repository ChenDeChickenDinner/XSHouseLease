//
//  XSBusinessInfoSever.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBusinessInfoSever.h"

@implementation XSBusinessInfoSever
DEF_SINGLETON(XSBusinessInfoSever)

- (NSMutableArray<XSBusinessInfoJsonModel *> *)businessInfoArray{
    if (_businessInfoArray == nil) {
        _businessInfoArray = [NSMutableArray array];
        NSError *error;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"XSHouseBusinessInfo" ofType:@"json"];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
        _businessInfoArray = [XSBusinessInfoJsonModel mj_objectArrayWithKeyValuesArray:dataArray];
    }
    return _businessInfoArray;
}
- (NSMutableArray<XSHouseDetailsFacilitiesModel *> *)facilitiesInfoArray{
    if (_facilitiesInfoArray == nil) {
        _facilitiesInfoArray = [NSMutableArray array];
        NSError *error;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"XSFacilitiesInfoJson" ofType:@"json"];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
        _facilitiesInfoArray = [XSHouseDetailsFacilitiesModel mj_objectArrayWithKeyValuesArray:dataArray];
    }
    return _facilitiesInfoArray;
}
@end
