//
//  XSHouseRentInfoModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseRentInfoModel.h"
#import "XSHouseSubCollectionviewBCell.h"

@implementation XSHouseEnumDataEnumRes

@end


@implementation XSHouseEnumData

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"enumRes":@"XSHouseEnumDataEnumRes"};
}

@end
@implementation XSValue
- (void)setValue:(NSNumber *)value{
    _value = value;
    [self infoLog];
    if (self.updateBlack)self.updateBlack();
}
- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    [self infoLog];
    if (self.updateBlack)self.updateBlack();
}
- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    [self infoLog];
    if (self.updateBlack)self.updateBlack();
}

- (void)infoLog{
  NSLog(@"name = %@,key = %@,value = %@,valueStr = %@,sendStr = %@",self.keyStr,self.key,self.value,self.valueStr,self.sendType == XSValueSendType_Int?self.value:self.valueStr);
}
@end


@implementation XSKeyValueModel

#pragma mark -当value更新的时候完成字典赋值
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
                if (weakSelf.multiple) {
                    NSMutableArray *valueArray = [NSMutableArray array];
                    
                    NSString *valueStr = [[NSString alloc]init];
                    for (XSValue *value in weakSelf.values) {
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
                    if (valueStr.length > 0) {
                    }
                    [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:valueArray];

//                    [[XSHouseFixedData sharedInstance] subRentParameterDictUpdateWithKey:weakSelf.key value:valueStr];

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
        value.key = _key;
        value.keyStr = _name;
        value.updateBlack = _updateBlack;
    }
    _values = values;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"values" : @"XSValue"};
}
@end




@implementation XSHouseInfoCellModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"arrayValue" : @"XSKeyValueModel"};
}

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
    valueModel.multiple = model.multiple;
    valueModel.keyInputType = XSValueInputType_collectionview;
    valueModel.values = arrayValue;
    
    XSHouseInfoCellModel *cellModel = [[XSHouseInfoCellModel alloc]init];
    cellModel.title = model.name;
    cellModel.sequence = model.type;
    cellModel.arrayValue = [NSMutableArray arrayWithObject:valueModel];
    cellModel.cellClass = NSStringFromClass([XSHouseSubCollectionviewBCell class]);
    if (model.enumRes.count > 4) {
        cellModel.cellHeight = [NSNumber numberWithInt:120];
    }else{
        cellModel.cellHeight = [NSNumber numberWithInt:80];
    }

    return cellModel;
}

@end

@implementation XSKeyValue
@end





@implementation XSBHouseInfoModel
@end


@implementation XSHouseRentInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"house_id":@"id"};
}
- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}
@end



@implementation XSHouseDetailsInfoCellModel

@end




