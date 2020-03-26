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

    [self city_tree];
    
    
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
- (void)loadRentEnums{
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
            
            [self.secondArray addObjectsFromArray:newArray];
            [self.array removeAllObjects];
            [self.array addObjectsFromArray:self.secondArray];
            [self refreshUIData];
        }
    }];
}
- (void)uploadImage:(UIImage *)image callback:(HBCompletionBlock)callback{
    [self.subInfoInterface uploadImage:image callback:callback];
}
-(void)city_tree{
    
    WEAK_SELF;
    [self.subInfoInterface city_treeWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
//        [responseModel.data mj_JSONData];
//        [YBModelFile createFileWithName:@"XSCity" data:[responseModel.data mj_JSONData]];

        NSMutableArray *modelArray = [BRProvinceModel mj_objectArrayWithKeyValuesArray:responseModel.data];
  
        [XSHouseFixedData sharedInstance].cityArray = modelArray;
    }];
}



- (NSMutableArray *)getDataWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:dataArray];
    return modelArray;
}


@end
