//
//  XSHouseDetailsModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/04/11.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseDetailsModel.h"

//基本信息
@implementation XSHouseDetailsDataBasicModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
//基本销售信息
@implementation XSHouseDetailsDataSellBasicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}
@end
//小区概况
@implementation XSHouseDetailsDataEstateBasicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}
@end

//预售许可证
@implementation XSHouseDetailsDataLicenceBasicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}
@end
//楼栋信息
@implementation XSHouseDetailsDataBuildingCellBasicInfosModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

//楼栋信息
@implementation XSHouseDetailsDataBuildingCellBasicModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"infos" : @"XSHouseDetailsDataBuildingCellBasicInfosModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}
@end


//动态信息
@implementation XSHouseDetailsDataDynamicsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

//相册
@implementation XSHouseDetailsDataImgsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}
@end





//户型列表
@implementation XSHouseDetailsDataFormsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"NewHouseId":@"newHouseId"};
}

@end


@implementation XSHouseDetailsDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"forms":@"XSHouseDetailsDataFormsModel", @"dynamics":@"XSHouseDetailsDataDynamicsModel", @"imgs":@"XSHouseDetailsDataImgsModel"};
}
@end



