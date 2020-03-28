//
//  XSHouseInfoModel.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseInfoModel.h"
#import "XSHouseSubCollectionviewBCell.h"

@implementation XSValue
- (void)setValue:(NSNumber *)value{
    _value = value;
    [self keyValueUpdate];
    [self infoLog];
}
- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    [self keyValueUpdate];
    [self infoLog];
}
- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    [self keyValueUpdate];
    [self infoLog];
}
- (void)keyValueUpdate{
    
    if (self.updateBlack) {
        self.updateBlack();
    }
   
}
- (void)infoLog{
    return;
  NSLog(@"name = %@,key = %@,value = %@,valueStr = %@,sendStr = %@",self.keyStr,self.key,self.value,self.valueStr,self.sendType == XSValueSendType_Int?self.value:self.valueStr);
}
@end


@implementation XSKeyValueModel
- (instancetype)init{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.updateBlack = ^(){
            
            
            if (weakSelf.values.count == 1) {
              // 1 个
                XSValue *value = weakSelf.values.firstObject;
                if (value.sendType == XSValueSendType_Int) {
                   [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:value.value];
                }else{
                   [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:value.valueStr];
                }
            }else{
              // 多个 个
                if (weakSelf.moreSelect) {
                    NSString *valueStr = [[NSString alloc]init];
                    for (XSValue *value in weakSelf.values) {
                         if (value.isSelect) {
                            if (value.sendType == XSValueSendType_Int) {
                                valueStr = [valueStr stringByAppendingFormat:@"%@,",value.value.stringValue];
                            }else{
                               valueStr = [valueStr stringByAppendingFormat:@"%@,",value.valueStr];
                            }
                         }
                    }
                    if (valueStr.length > 0) {
                        [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:valueStr];
                    }

               
              }else{
                 // 单选
                  for (XSValue *value in weakSelf.values) {
                      if (value.isSelect) {
                            if (value.sendType == XSValueSendType_Int) {
                                [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:value.value];
                            }else{
                                [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:value.valueStr];
                            }
                      }
                  }
              }
            }
            
         
  
        };
    }
    return self;
}
- (void)setValues:(NSArray<XSValue *> *)values{
    for (XSValue *value in values) {
        value.key = self.key;
        value.keyStr = self.name;
        value.updateBlack = self.updateBlack;
    }
    _values = values;

}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"values" : @"XSValue"};//前边，是属性数组的名字，后边就是类名
}
@end

@implementation XSHouseInfoCellModel
- (instancetype)initwithEnumData:(XSHouseEnumData *)model{
    
    // 1.value可选项数组
    NSMutableArray *arrayValue = [NSMutableArray array];
    for (XSHouseEnumDataEnumRes *enumres in model.enumRes) {
        XSValue *value = [[XSValue alloc]init];
        value.value = enumres.value;
        value.valueStr = enumres.name;
        value.sendType = XSValueSendType_Int;
        [arrayValue addObject:value];
    }
    
    // 一个keyValue 数据
    XSKeyValueModel *valueModel = [[XSKeyValueModel alloc]init];
    valueModel.name = model.name;
    valueModel.key = model.key;
    valueModel.sequence = model.type;
    if ([model.name isEqualToString:@"配套设施"]||[model.name isEqualToString:@"房源特色"]) {
        valueModel.moreSelect = YES;
    }else{
        valueModel.moreSelect = NO;
    }
    valueModel.keyInputType = XSValueInputType_collectionview;
    valueModel.values = arrayValue;
    
    XSHouseInfoCellModel *cellModel = [[XSHouseInfoCellModel alloc]init];
    cellModel.title = model.name;
    cellModel.sequence = model.type;
    cellModel.arrayValue = [NSMutableArray arrayWithObject:valueModel];
    cellModel.cellClass = NSStringFromClass([XSHouseSubCollectionviewBCell class]);
    cellModel.cellHeight = [NSNumber numberWithInt:120];
    return cellModel;
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"arrayValue" : @"XSKeyValueModel"};//前边，是属性数组的名字，后边就是类名
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


@implementation XSKeyValue
@end
