//
//  XSPublicServer.m
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSPublicServer.h"

@interface XSPublicServer()



@end


@implementation XSPublicServer
DEF_SINGLETON(XSPublicServer)

- (NSMutableArray<XSHouseModuleModel *> *)newhouseConditionArray{
    if (!_newhouseConditionArray) {
        _newhouseConditionArray = [NSMutableArray array];
        XSHouseModuleModel *ob1 = [[XSHouseModuleModel alloc]init];
        ob1.key = @"";
        ob1.value = [NSNumber numberWithInt:1];
        ob1.name = @"全部楼盘";
        ob1.iconName = @"newC1";

        XSHouseModuleModel *ob2 = [[XSHouseModuleModel alloc]init];
        ob2.key = @"";
        ob2.value = [NSNumber numberWithInt:1];
        ob2.name = @"在售楼盘";
        ob2.iconName = @"newC2";
        XSHouseModuleModel *ob3 = [[XSHouseModuleModel alloc]init];
        ob3.key = @"";
        ob3.value = [NSNumber numberWithInt:1];
        ob3.name = @"最近开盘";
        ob3.iconName = @"newC3";
        XSHouseModuleModel *ob4 = [[XSHouseModuleModel alloc]init];
        ob4.key = @"";
        ob4.value = [NSNumber numberWithInt:1];
        ob4.name = @"地铁沿线";
        ob4.iconName = @"newC4";
        [_newhouseConditionArray addObject:ob1];
        [_newhouseConditionArray addObject:ob2];
        [_newhouseConditionArray addObject:ob3];
        [_newhouseConditionArray addObject:ob4];

    }
    return _newhouseConditionArray;
}
- (NSMutableArray<XSHouseModuleModel *> *)secondhouseConditionArray{
    if (!_secondhouseConditionArray) {
          _secondhouseConditionArray = [NSMutableArray array];
      }
      return _secondhouseConditionArray;
}
- (NSMutableArray<XSHouseKeyVlaueModel *> *)rentHouseInfoBArray{
    if (!_rentHouseInfoBArray) {
        NSError *error;
         NSString *path = [[NSBundle mainBundle]pathForResource:@"XSRentHouseInfoB" ofType:@"json"];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
        _rentHouseInfoBArray =[XSHouseKeyVlaueModel mj_objectArrayWithKeyValuesArray:dataArray];
    }
    return _rentHouseInfoBArray;
}
- (NSMutableArray<XSHouseKeyVlaueModel *> *)secondHouseInfoBArray{
    if (!_secondHouseInfoBArray) {
        NSError *error;
         NSString *path = [[NSBundle mainBundle]pathForResource:@"XSSecondHouseInfoB" ofType:@"json"];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
        _secondHouseInfoBArray =[XSHouseKeyVlaueModel mj_objectArrayWithKeyValuesArray:dataArray];
    }
    return _secondHouseInfoBArray;
}
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





- (void)cityTreeWithCallback:(HBCompletionBlock)callback{
    
     [self.requestVc.subInfoInterface city_treeWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
         if (error==nil && responseModel.code.integerValue == SuccessCode) {
               NSMutableArray *modelArray = [BRProvinceModel mj_objectArrayWithKeyValuesArray:responseModel.data];
               [XSPublicServer sharedInstance].cityArray = modelArray;
         }
         if (callback)callback(responseModel,error);
      }];
   
}

- (void)bunnerListWithCallback:(HBCompletionBlock)callback{
    [self.requestVc.subInfoInterface bunnerListWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
          if (error==nil && responseModel.code.integerValue == SuccessCode) {
                      
              NSMutableArray *modelArray = [XSHousePicture mj_objectArrayWithKeyValuesArray:responseModel.data];
              [XSPublicServer sharedInstance].bunnerArray = modelArray;
              
          }
        if (callback)callback(responseModel,error);

      }];
}

- (void)hotsSearchWithCallback:(HBCompletionBlock)callback{
    [self.requestVc.subInfoInterface hotsSearchWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
         if (error==nil && responseModel.code.integerValue == SuccessCode) {
              NSMutableArray *modelArray = [XSHousehots mj_objectArrayWithKeyValuesArray:responseModel.data];
              [XSPublicServer sharedInstance].hotsSearchArray = modelArray;
          }
        if (callback)callback(responseModel,error);

     }];
}
- (void)enumFacilitiesWithCallback:(HBCompletionBlock)callback{
    [self.requestVc.subInfoInterface enumFacilitiesWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
         if (error==nil && responseModel.code.integerValue == SuccessCode) {
              NSMutableArray *modelArray = [XSHouseFacilitiesModel mj_objectArrayWithKeyValuesArray:responseModel.data];
              [XSPublicServer sharedInstance].facilitiesArray = modelArray;
          }
        if (callback)callback(responseModel,error);

     }];
}

- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback{
    [self.requestVc.subInfoInterface renthouseConditionWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
            NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:responseModel.data];
            [XSPublicServer sharedInstance].renthouseConditionArray = modelArray;
        }
        if (callback)callback(responseModel,error);

    }];
}
@end
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
@implementation XSHouseLocationModel
+ (instancetype)LocationModelWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area{
    XSHouseLocationModel *model = [[XSHouseLocationModel alloc]init];
    model.city = province.name;
    model.cityId = [NSNumber numberWithInteger:province.code.integerValue];

    model.region = city.name;
    model.regionId = [NSNumber numberWithInteger:city.code.integerValue];

    model.town = area.name;
    model.townId = [NSNumber numberWithInteger:area.code.integerValue];
    
    return model;
}
@end
@implementation XSHouseFacilitiesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation XSHouseKeyVlaueModel

@end
@implementation XSHouseModuleModel

@end
