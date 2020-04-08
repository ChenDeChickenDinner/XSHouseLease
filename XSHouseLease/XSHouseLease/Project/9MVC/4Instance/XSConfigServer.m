//
//  XSConfigServer.m
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSConfigServer.h"

@implementation XSConfigServer
DEF_SINGLETON(XSConfigServer)

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




@implementation XSHouseDetailsFacilitiesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
@implementation XSBusinessInfoJsonModel
@end

@implementation XSBusinessInfoModel

@end
@implementation XSHouseModuleModel

@end
