//
//  XSHouseSubMitModel.m
//  XSHouseLease
//
//  Created by xs on 2020/4/9.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubMitModel.h"
#import "XSHouseSubTableViewCell.h"


@implementation XSValue
- (void)setValue:(NSNumber *)value{
    _value = value;
    [self infoLog];
      if (self.updateBlack) {
        self.updateBlack();
    }
}
- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    [self infoLog];
      if (self.updateBlack) {
        self.updateBlack();
    }
}
- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    [self infoLog];
    if (self.updateBlack) {
        self.updateBlack();
    }
}
- (void)infoLog{
//  NSLog(@"name = %@,key = %@,value = %@,valueStr = %@,sendStr = %@",self.keyStr,self.key,self.value,self.valueStr,self.sendType == XSValueSendType_Int?self.value:self.valueStr);
}
@end


@implementation XSKeyValueModel
- (instancetype)init{
    self = [super init];
    if (self) {
     
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
@end




@implementation XSHouseEnumDataEnumRes
@end
@implementation XSHouseEnumData
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"enumRes":@"XSHouseEnumDataEnumRes"};
}
- (XSHouseInfoCellModel *)combinationToCellModel{
    
    // 1.value可选项数组
    NSMutableArray *arrayValue = [NSMutableArray array];
    for (XSHouseEnumDataEnumRes *enumres in self.enumRes) {
        XSValue *value = [[XSValue alloc]init];
        value.value = enumres.value;
        value.valueStr = enumres.name;
        value.sendType = XSValueSendType_Int;
        [arrayValue addObject:value];
    }
    
    // 一个keyValue 数据
    XSKeyValueModel *valueModel = [[XSKeyValueModel alloc]init];
    valueModel.name = self.name;
    valueModel.key = self.key;
    valueModel.sequence = self.type;
    valueModel.multiple = self.multiple;
    valueModel.keyInputType = XSValueInputType_collectionview;
    valueModel.values = arrayValue;
    
    XSHouseInfoCellModel *cellModel = [[XSHouseInfoCellModel alloc]init];
    cellModel.title = self.name;
    cellModel.sequence = self.type;
    cellModel.arrayValue = [NSMutableArray arrayWithObject:valueModel];
    cellModel.cellClass = NSStringFromClass([XSHouseSubCollectionviewBCell class]);
    if (self.enumRes.count > 4) {
        cellModel.cellHeight = [NSNumber numberWithInt:120];
    }else{
        cellModel.cellHeight = [NSNumber numberWithInt:80];
    }
    
    return cellModel;

}
@end
