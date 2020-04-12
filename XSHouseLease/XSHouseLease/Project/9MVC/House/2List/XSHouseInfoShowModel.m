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

-(NSArray *)houseInfoBArray{
    NSMutableDictionary *modeDict = [self mj_keyValues];
    NSMutableArray *infoArray = [NSMutableArray array];
    NSArray *sourceArray = self.houseType==XSBHouseType_Rent?[XSPublicServer sharedInstance].rentHouseInfoBArray:[XSPublicServer sharedInstance].secondHouseInfoBArray;
    for (XSHouseInfoBModel *infoJsonModel in sourceArray) {
        id value = [modeDict safeObjectForKey:infoJsonModel.key];
         XSHouseInfoBModel *infoModel = [[XSHouseInfoBModel alloc]init];
          infoModel.key = infoJsonModel.key ;
         infoModel.keyName = infoJsonModel.keyName ;
        if ([infoJsonModel.key isEqualToString:@"floor"]) {//楼层
            infoModel.value = [NSString stringWithFormat:@"%@层(共%@层)",self.floor,self.totalFloor];
          }else if ([infoJsonModel.key isEqualToString:@"elevator"]){//电梯
              infoModel.value = self.elevator.intValue?@"有":@"无";
          }else if ([infoJsonModel.key isEqualToString:@"createYears"]){//年代
              infoModel.value = [NSString stringWithFormat:@"%@年建成",self.createYears];
          }else if ([infoJsonModel.key isEqualToString:@"other"]){//其他
              infoModel.value = [NSString stringWithFormat:@"产权年限 梯户比 >"];
          }else{
              infoModel.value = [NSString stringWithFormat:@"%@",value?value:@""];
          }
         [infoArray addObject:infoModel];
     }
    return infoArray;
}
@end






