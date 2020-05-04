//
//  XSHouseSubMitServer.m
//  XSHouseLease
//
//  Created by xs on 2020/4/9.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubMitServer.h"


@implementation XSHouseSubMitDynamicServer
DEF_SINGLETON(XSHouseSubMitDynamicServer)

- (instancetype)init{
    self = [super init];
    if (self) {
        [self combinationDynamicSubmitData];
    }
    return self;
}

- (void)combinationDynamicSubmitData{
    WEAK_SELF;
    [self.requestVc.subInfoInterface getRentEnumsWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
 
            STRONG_SELF;
            [self dealDataWitHresponseModel:responseModel black:^(NSArray *array) {
                 self.rentSecondDynamicArray = array;
             }];
//            NSArray *enumData  =  [XSHouseEnumData mj_objectArrayWithKeyValuesArray:responseModel.data];
//            NSLog(@"sub动态 = %@", [enumData mj_keyValues]);
//            NSMutableArray *array = [NSMutableArray array];
//            for (XSHouseEnumData *model in enumData) {
//                XSHouseInfoCellModel *cellModel =  [model combinationToCellModel];
//                [array addObject:cellModel];
//            }
//             NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(XSHouseInfoCellModel *obj1, XSHouseInfoCellModel *obj2) {
//                 return obj1.sequence.integerValue <  obj2.sequence.integerValue ?NSOrderedAscending:NSOrderedDescending;;
//            }];
//            self.rentSecondDynamicArray = newArray;
        }
    }];
    
    [self.requestVc.subInfoInterface getSellEnumsWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
         if (error == nil && responseModel.code.integerValue == SuccessCode) {
             STRONG_SELF;
             [self dealDataWitHresponseModel:responseModel black:^(NSArray *array) {
                  self.sellSecondDynamicArray = array;
              }];
         }
     }];
    
    [self.requestVc.subInfoInterface getQueryEnumsWithhouseType:XSBHouseType_New callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
                STRONG_SELF;
                [self dealDataWitHresponseModel:responseModel black:^(NSArray *array) {
                     self.NewQueryArray = array;
                 }];
           }
    }];
    [self.requestVc.subInfoInterface getQueryEnumsWithhouseType:XSBHouseType_old callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
                STRONG_SELF;
                [self dealDataWitHresponseModel:responseModel black:^(NSArray *array) {
                     self.oldQueryArray = array;
                 }];
           }
    }];
    [self.requestVc.subInfoInterface getQueryEnumsWithhouseType:XSBHouseType_Rent callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
                STRONG_SELF;
                [self dealDataWitHresponseModel:responseModel black:^(NSArray *array) {
                     self.rentQueryArray = array;
                 }];
           }
    }];
}
- (void)dealDataWitHresponseModel:(XSNetworkResponse *)responseModel black:(void(^)(NSArray *array))black{
    NSArray *enumData  =  [XSHouseEnumData mj_objectArrayWithKeyValuesArray:responseModel.data];
    NSLog(@"sub动态 = %@", [enumData mj_keyValues]);
    NSMutableArray *array = [NSMutableArray array];
    for (XSHouseEnumData *model in enumData) {
        XSHouseInfoCellModel *cellModel =  [model combinationToCellModel];
        [array addObject:cellModel];
    }
     NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(XSHouseInfoCellModel *obj1, XSHouseInfoCellModel *obj2) {
         return obj1.sequence.integerValue <  obj2.sequence.integerValue ?NSOrderedAscending:NSOrderedDescending;;
    }];
    if (black) {
        black(newArray);
    }
}
@end



@implementation XSHouseSubMitServer

- (NSMutableArray *)imageUrlArray{
    if (!_imageUrlArray) {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}
- (NSMutableArray *)imageUrlServerArray{
    if (!_imageUrlServerArray) {
        _imageUrlServerArray = [NSMutableArray array];
    }
    return _imageUrlServerArray;
}
- (NSMutableArray *)imageDoorUrlArray{
    if (!_imageDoorUrlArray) {
        _imageDoorUrlArray = [NSMutableArray array];
    }
    return _imageDoorUrlArray;
}
- (NSMutableArray *)imageDoorUrlServerArray{
    if (!_imageDoorUrlServerArray) {
        _imageDoorUrlServerArray = [NSMutableArray array];
    }
    return _imageDoorUrlServerArray;
}
- (NSMutableDictionary *)subRentParameterDict{
    if (!_subRentParameterDict) {
        _subRentParameterDict = [NSMutableDictionary dictionary];
    }
    return _subRentParameterDict;
}


#pragma mark -初始化读取默认配置数据
- (void)resetData{
    self.firstArray = nil;
}
- (NSMutableArray<XSHouseInfoCellModel *> *)firstArray{
    if (!_firstArray) {
       
        if (self.houseType == XSBHouseType_Rent) {
            _firstArray  = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSRentHouseInfoFirst"]];
             _secondArray = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSRentHouseInfoSecond"]];
             _thirdArray  = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSRentHouseInfoThird"]];
             [_secondArray addObjectsFromArray:[XSHouseSubMitDynamicServer sharedInstance].rentSecondDynamicArray.mutableCopy];
        }else{
            _firstArray  = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSSellHouseInfoFirst"]];
             _secondArray = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSSellHouseInfoSecond"]];
             _thirdArray  = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:[self getDictWithJsonName:@"XSSellHouseInfoThird"]];
             [_secondArray addObjectsFromArray:[XSHouseSubMitDynamicServer sharedInstance].sellSecondDynamicArray.mutableCopy];
        }
 
        
        [self setUpdataBlacokWithArray:_firstArray];
        [self setUpdataBlacokWithArray:_secondArray];
        [self setUpdataBlacokWithArray:_thirdArray];

    }
    return _firstArray;
}
- (void)setUpdataBlacokWithArray:(NSArray<XSHouseInfoCellModel *> *)array{
    for (XSHouseInfoCellModel *cellModel in array) {
        for (XSKeyValueModel *keyValue in cellModel.arrayValue) {
            __weak typeof(keyValue) weakKeyValue = keyValue;
            keyValue.updateBlack = ^{
                
                if (weakKeyValue.values.count == 1) {
                  // 1 个
                    XSValue *value = weakKeyValue.values.firstObject;
                    [self.subRentParameterDict safeSetObject:value.sendType == XSValueSendType_Int?value.value:value.valueStr forKey:weakKeyValue.key];

                }else{
                  // 多个 个
                    if (weakKeyValue.multiple) {
                        NSMutableArray *valueArray = [NSMutableArray array];
                        NSString *valueStr = [[NSString alloc]init];
                        for (XSValue *value in weakKeyValue.values) {
                             if (value.isSelect) {
                                if (value.sendType == XSValueSendType_Int) {
                                    [valueArray addObject:value.value];
                                    valueStr = [valueStr stringByAppendingFormat:@"%@,",value.value];
                                }else{
                                   valueStr = [valueStr stringByAppendingFormat:@"%@,",value.valueStr];
                                    [valueArray addObject:value.valueStr];
                                }
                             }
                        }
                        [self.subRentParameterDict safeSetObject:valueArray forKey:weakKeyValue.key];

                  }else{
                     // 单选
                      for (XSValue *value in weakKeyValue.values) {
                          if (value.isSelect) {
                            [self.subRentParameterDict safeSetObject:value.sendType == XSValueSendType_Int?value.value:value.valueStr forKey:weakKeyValue.key];
                          }
                      }
                  }
                }
                NSLog(@"self.subRentParameterDict = %@",self.subRentParameterDict);
            };
            
            for (XSValue *value in keyValue.values) {
                value.updateBlack = keyValue.updateBlack;
            }
        }
    }
}
- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value{
    [self.subRentParameterDict safeSetObject:value forKey:key];
}
- (void)setResource:(XSHouseSource)resource{
    _resource = resource;
    for (XSHouseInfoCellModel *cellModel in self.firstArray) {
        
        for (XSKeyValueModel *oldvalueModel in cellModel.arrayValue) {
            
            for (XSValue *oldValue in oldvalueModel.values) {
                if ([oldValue.key isEqualToString:@"resource"]) {
                    if (_resource == XSHouseSource_1) {
                        oldValue.valueStr = @"个人房源";
                    }else if (_resource == XSHouseSource_2){
                        oldValue.valueStr = @"中介房源";
                    }else{
                        oldValue.valueStr = @"全部房源";
                    }
                }
            }
            
        }
        
    }
    [self.subRentParameterDict safeSetObject:[NSNumber numberWithInteger:resource] forKey:@"resource"];
}
#pragma mark - 再次编辑信息
- (void)setRenhousetInfoModel:(XSHouseInfoShowModel *)renhousetInfoModel{
    [self resetData];
    if (renhousetInfoModel) {
        _renhousetInfoModel = renhousetInfoModel;
        self.resource = renhousetInfoModel.resource;
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.house_id forKey:@"id"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.city forKey:@"city"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.cityId forKey:@"cityId"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.region forKey:@"region"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.regionId forKey:@"regionId"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.town forKey:@"town"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.townId forKey:@"townId"];

        [self.subRentParameterDict safeSetObject:renhousetInfoModel.contentImg forKey:@"contentImg"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.firstImg forKey:@"firstImg"];
        [self.subRentParameterDict safeSetObject:renhousetInfoModel.modelImg forKey:@"modelImg"];
        [self.subRentParameterDict safeSetObject:[renhousetInfoModel.es mj_keyValues] forKey:@"es"];

        [self valueUpdatekWitOldhDict:[renhousetInfoModel mj_keyValues]];
    }


}
- (void)valueUpdatekWitOldhDict:(NSDictionary *)dict{
    [self valueUpdatekWitOldhDict:dict array:self.firstArray];
    [self valueUpdatekWitOldhDict:dict array:self.secondArray];
    [self valueUpdatekWitOldhDict:dict array:self.thirdArray];

}


- (void)valueUpdatekWitOldhDict:(NSDictionary *)dict array:(NSArray<XSHouseInfoCellModel *> *)array{
    for (XSHouseInfoCellModel *cellModel in array) {
        
        for (XSKeyValueModel *oldvalueModel in cellModel.arrayValue) {
            
            for (XSValue *oldValue in oldvalueModel.values) {
                id newValue = [dict objectForKey:oldValue.key];
                
                if ([oldValue.key isEqualToString:@"contentImg"]) {
                    oldValue.imgs = newValue;
                }else if ([oldValue.key isEqualToString:@"modelImg"]){
                    oldValue.imgs = newValue?[NSArray arrayWithObject:newValue]:nil;
                }
                  NSLog(@"key = %@,value = %@，valueClass= %@",oldValue.key,newValue,NSStringFromClass([newValue class]));
                
                if (oldValue.sendType == XSValueSendType_Int) {
                       if ([newValue isKindOfClass:[NSArray class]]) {
                              NSArray *newValueArray = (NSArray *)newValue;
                              for (id newsubValue in newValueArray) {
                                  NSString *newsubValueStr = [NSString stringWithFormat:@"%@",newsubValue];
                                  if ([newsubValueStr isEqualToString:oldValue.value.stringValue]) {
                                      oldValue.isSelect = YES;
                                  }
                              }
                       }else{
                           NSString *newValueStr = [NSString stringWithFormat:@"%@",newValue];

                           if ([newValueStr isEqualToString:oldValue.value.stringValue]) {
                              oldValue.isSelect = YES;
                           }
                       }
                    if (oldValue.value == nil) {
                        oldValue.value = newValue;
                    }
                }else{
                   oldValue.valueStr = newValue;
                }
            }

        }
    }


}


- (void)automaticAssignment:(NSArray *)array{
    for (XSHouseInfoCellModel *cell in array) {
        for (XSKeyValueModel *valueModel in cell.arrayValue) {
            for (XSValue *model in valueModel.values) {
                model.value = model.value;
                model.valueStr = model.valueStr;
            }
        }
    }
    
}
@end
