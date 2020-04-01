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
                 id newvalue1 = [dict objectForKey:oldValue.key];
                   NSLog(@"key = %@,value = %@，valueClass= %@",oldValue.key,newvalue1,NSStringFromClass([newvalue1 class]));
                     if ([newvalue1 isKindOfClass:[NSArray class]]) {
                            NSArray *newArray = (NSArray *)newvalue1;
                            for (id newValue2 in newArray) {
                                NSString *newValue2Str = [NSString stringWithFormat:@"%@",newValue2];
                                
                                if ([newValue2Str isEqualToString:oldValue.value.stringValue]) {
                                    oldValue.isSelect = YES;
                                }
//                                else if (newValue2 == oldValue.value.integerValue ) {
//                                   oldValue.isSelect = YES;
//                                }else if (newValue2 == oldValue.value.longValue){
//                                    oldValue.isSelect = YES;
//                                }else if (newValue2 == oldValue.value.doubleValue){
//                                    oldValue.isSelect = YES;
//                                }
                                 
                         
                            }
                     }else{
                            if (oldValue.sendType == XSValueSendType_Int) {
                      
                                oldValue.value = newvalue1;
                            }else{
                               oldValue.valueStr = newvalue1;
                            }
                     }
                 
             }
   
     

         }
     }
 }
- (void)loadRentEnumsCallback:(HBCompletionBlock)callback arrayBlack:(void (^)(NSArray *newArray))arrayBlack{
 WEAK_SELF;
 [self.subInfoInterface getRentEnumsWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
     if (error == nil && responseModel.code.integerValue == SuccessCode) {
         STRONG_SELF;
        XSHouseEnum *enumData  =  [XSHouseEnum mj_objectWithKeyValues:responseModel];
         NSLog(@"enumData = %@", [enumData mj_keyValues]);
         NSMutableArray *array = [NSMutableArray array];
         for (XSHouseEnumData *model in enumData.data) {
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


@end
