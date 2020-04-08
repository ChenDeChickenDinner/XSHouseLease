//
//  XSHouseSubmitBaseViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubmitBaseViewController.h"
#import "XSHouseEnum.h"

@interface XSHouseSubmitBaseViewController ()

@end

@implementation XSHouseSubmitBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.firstArray = [self getDataWithJsonName:@"XSHouseInfoFirst"];
    self.secondArray = [self getDataWithJsonName:@"XSHouseInfoSecond"];
    self.thirdArray = [self getDataWithJsonName:@"XSHouseInfoThird"];
 

    
//    self.firstArray = [self getDataWithJsonName:@"XSHouseInfoFirstTest"];
//    self.secondArray = [self getDataWithJsonName:@"XSHouseInfoSecondTest"];
//    self.thirdArray = [self getDataWithJsonName:@"XSHouseInfoThirdTest"];
    [self refreshUIData];

}
 - (void)keyValueUpdatekWitOldhDict:(NSDictionary *)dict  array:(NSArray<XSHouseInfoCellModel *> *)array{
     for (XSHouseInfoCellModel *cellModel in array) {
         
         for (XSKeyValueModel *oldvalueModel in cellModel.arrayValue) {
             
             for (XSValue *oldValue in oldvalueModel.values) {
                 id newValue = [dict objectForKey:oldValue.key];
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
     
     if (self.submitStepsType == XSHouseSubmitStepsType_First) {
         BRProvinceModel * model1 = [[BRProvinceModel alloc]init];
         model1.name = [dict objectForKey:@"city"];
         model1.code = [dict objectForKey:@"cityId"];

         BRCityModel * model2 = [[BRCityModel alloc]init];
         model2.name = [dict objectForKey:@"region"];
         model2.code = [dict objectForKey:@"regionId"];
          
         BRAreaModel * model3 = [[BRAreaModel alloc]init];
         model3.name = [dict objectForKey:@"town"];
         model3.code = [dict objectForKey:@"townId"];
          [[XSHouseFixedData sharedInstance].subRentParameterDict safeSetObject:[dict objectForKey:@"id"] forKey:@"id"];
         [[XSHouseFixedData sharedInstance] LocationParameterUpdateWithProvince:model1 city:model2 area:model3];
     }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
         self.imageUrlServerArray = [dict objectForKey:@"contentImg"];

     }

     
     
 }
- (void)loadRentEnumsCallback:(HBCompletionBlock)callback arrayBlack:(void (^)(NSArray *newArray))arrayBlack{
 WEAK_SELF;
 [self.subInfoInterface getRentEnumsWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
     if (error == nil && responseModel.code.integerValue == SuccessCode) {
         STRONG_SELF;
         NSArray *enumData  =  [XSHouseEnumData mj_objectArrayWithKeyValuesArray:responseModel.data];
         NSLog(@"enumData = %@", [enumData mj_keyValues]);
         NSMutableArray *array = [NSMutableArray array];
         for (XSHouseEnumData *model in enumData) {
             XSHouseInfoCellModel *cellModel =  [[XSHouseInfoCellModel alloc]initwithEnumData:model];
             [array addObject:cellModel];
         }
          NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(XSHouseInfoCellModel *obj1, XSHouseInfoCellModel *obj2) {
              return obj1.sequence.integerValue <  obj2.sequence.integerValue ?NSOrderedAscending:NSOrderedDescending;;
         }];
         if (arrayBlack) {
             arrayBlack(newArray);
           }
     }
 }];
}


- (void)keyValueUpdateBlackWithArray:(NSArray<XSHouseInfoCellModel *> *)array{
    for (XSHouseInfoCellModel *cellModel in array) {
        for (XSKeyValueModel *valueModel in cellModel.arrayValue) {
            valueModel.updateBlack= ^(){
                
            };
        }
    }
}

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}




- (NSMutableArray *)getDataWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:dataArray];
    return modelArray;
}


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

@end
