//
//  XSHouseInfoShowModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseInfoShowModel.h"
@implementation XSHouseEsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
@implementation XSHouseInfoModel

- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}
- (void)setHouseType:(XSBHouseType)houseType{
    _houseType = houseType;
    
}
@end
@implementation XSHouseInfoShowModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"house_id":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"forms":@"XSHouseDetailsDataFormsModel", @"dynamics":@"XSHouseDetailsDataDynamicsModel", @"imgs":@"XSHouseDetailsDataImgsModel"};
}
-(XSHouseKeyValueModuleModel *)houseInfoBArrayWithSourceType:(XSBHouseKeyValueDataSource)type{
    NSMutableDictionary *modeDict = [self mj_keyValues];
    XSHouseKeyValueModuleModel *model = [XSPublicServer houseInfoArrayForSourceType:type];
    for (XSHouseKeyVlaueModel *KeyVlaueModel in model.array) {
        id value = [modeDict safeObjectForKey:KeyVlaueModel.key];
          if ([KeyVlaueModel.key isEqualToString:@"floor"]) {//楼层
            KeyVlaueModel.value = [NSString stringWithFormat:@"%@层(共%@层)",self.floor,self.totalFloor];
          }else if ([KeyVlaueModel.key isEqualToString:@"elevator"]){//电梯
              KeyVlaueModel.value = self.elevator.intValue?@"有":@"无";
          }else if ([KeyVlaueModel.key isEqualToString:@"createYears"]){//年代
              KeyVlaueModel.value = [NSString stringWithFormat:@"%@年建成",self.createYears];
          }else if ([KeyVlaueModel.key isEqualToString:@"other"]){//其他
              KeyVlaueModel.value = [NSString stringWithFormat:@"产权年限 梯户比 >"];
          }else{
              KeyVlaueModel.value = [NSString stringWithFormat:@"%@",value?value:@""];
          }
     }
    return model;
}
@end






