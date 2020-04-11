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

- (NSMutableArray<XSHouseInfoBModel *> *)rentHouseInfoBArray{
    if (!_rentHouseInfoBArray) {
        NSError *error;
         NSString *path = [[NSBundle mainBundle]pathForResource:@"XSHouseInfoB" ofType:@"json"];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
        _rentHouseInfoBArray =[XSHouseInfoBModel mj_objectArrayWithKeyValuesArray:dataArray];
    }
    return _rentHouseInfoBArray;
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
//            for (XSHouseModuleModel *model in modelArray) {
//                model.clickBlack = ^(XSHouseModuleModel * _Nonnull model) {
//                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//                    [dict safeSetObject:[XSUserServer sharedInstance].cityModel.code forKey:@"cityId"];
//                    [dict safeSetObject:model.value forKey:model.key];
//                    XSMyPublishHosueController *vc = [[XSMyPublishHosueController alloc]init];
//                    vc.title = model.name;
//                    vc.source = XSBHouseInfoSource_Search;
//                    vc.houseType = XSBHouseType_Rent;
//                    vc.searchDict = dict;
//                };
//            }
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

@implementation XSHouseInfoBModel

@end
@implementation XSHouseModuleModel

@end
