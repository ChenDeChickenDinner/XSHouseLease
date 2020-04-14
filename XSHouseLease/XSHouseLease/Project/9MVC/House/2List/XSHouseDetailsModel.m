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



/*
 NewHouseDetails {
 basic (NewHouseBasicDTO, optional): 基本信息 ,
 billingDate (string, optional): 开盘日期 ,
 buildingCellBasic (NewHouseBuildingCellBasicDTO, optional): 楼栋信息 ,
 city (string, optional): 城市 ,
 cityId (integer, optional): 城市id ,
 contentImg (Array[string], optional): 内容照片 ,
 customerId (integer, optional),
 dealStatus (integer, optional): 1待售 2 在售 3售罄 ,
 dealStatusName (string, optional): 1待售 2 在售 3售罄 ,
 distance (number, optional),
 dynamics (Array[NewHouseDynamic], optional): 动态信息 ,
 estate (string, optional): 小区名字 ,
 estateBasic (NewHouseEstateBasicDTO, optional): 小区概况 ,
 estateId (integer, optional): 小区id ,
 featurePointNames (Array[string], optional),
 formNum (integer, optional): 户型数量 ,
 forms (Array[NewHouseFormDTO], optional): 户型列表 ,
 id (integer, optional),
 imgNum (integer, optional): 更多相册的数量 ,
 imgs (Array[NewHouseImgDTO], optional): 相册 ,
 latitude (number, optional): 维度 ,
 licenceBasic (NewHouseLicenceBasicDTO, optional): 预售许可证 ,
 longitude (number, optional): 经度 ,
 maxArea (number): 最大房屋面积 ,
 minArea (number): 最小房屋面积 ,
 purpose (integer, optional): 1普通住宅2商业类3别墅4四合院5车位6其他 ,
 purposeName (string, optional): 1普通住宅2商业类3别墅4四合院5车位6其他 ,
 push (integer, optional),
 referTotalPrice (number, optional): 参考总价 ,
 referUnitPrice (number, optional): 参考均价 ,
 region (string, optional): 区 ,
 regionId (integer, optional): 区id ,
 sellBasic (NewHouseSellBasicDTO, optional): 基本销售信息 ,
 title (string, optional): 房子标题 ,
 town (string, optional): 镇 ,
 townId (integer, optional): 镇id ,
 watch (boolean, optional): 是否关注
 }NewHouseBasicDTO {
 address (string, optional): 详细地址 ,
 billingDate (string, optional): 开盘日期 ,
 buildingType (integer, optional): 1塔楼2板楼3板塔结合 ,
 buildingTypeName (string, optional): 1塔楼2板楼3板塔结合 ,
 city (string, optional): 城市 ,
 cityId (integer, optional): 城市id ,
 customerId (integer, optional): 用户id ,
 customerName (string, optional): 用户名称 ,
 dealStatus (integer, optional): 交易状态 2 在售 3售罄 1待售 ,
 dealStatusName (string, optional): 交易状态 2 在售 3售罄 1待售 ,
 developers (string, optional): 开发商 ,
 estate (string, optional): 小区名字 ,
 estateAlias (string, optional): 小区别名 ,
 estateId (integer, optional): 小区id ,
 finish (integer, optional): 1精装修2简装修3毛坯 ,
 finishName (string, optional): 1精装修2简装修3毛坯 ,
 icon (string, optional): 用户头像 ,
 id (integer, optional),
 latitude (number, optional),
 longitude (number, optional),
 maxArea (number): 最大房屋面积 ,
 minArea (number): 最小房屋面积 ,
 ownership (integer, optional): 1商品房2公房3经适房4其他 ,
 ownershipName (string, optional): 1商品房2公房3经适房4其他 ,
 purpose (integer, optional): 1普通住宅2商业类3别墅4四合院5车位6其他 ,
 purposeName (string, optional): 1普通住宅2商业类3别墅4四合院5车位6其他 ,
 push (integer, optional),
 referTotalPrice (number, optional): 参考总价格 ,
 referUnitPrice (number, optional): 参考均价 ,
 region (string, optional): 区 ,
 regionId (integer, optional): 区id ,
 registration (integer, optional): 产权年限 ,
 town (string, optional): 镇 ,
 townId (integer, optional): 镇id
 }NewHouseBuildingCellBasicDTO {
 contentImg (string): 内容照片 ,
 dealStatus (integer, optional): 1待售 2 在售 3售罄 ,
 dealStatusName (string, optional): 1待售 2 在售 3售罄 ,
 id (integer, optional),
 infos (Array[NewHouseBuildingCellInfoDTO], optional): 楼栋信息 ,
 newHouseId (integer): 新房id
 }NewHouseDynamic {
 content (string): 内容 ,
 contentType (integer): 1是销控信息2其他 ,
 id (integer, optional),
 newHouseId (integer): 新房id
 }NewHouseEstateBasicDTO {
 greeningRatio (number): 绿化率 ,
 id (integer, optional),
 newHouseId (integer): 新房id ,
 parkingRatio (string): 车位配比 ,
 planBuilding (integer): 规划楼栋 ,
 planHouse (integer): 规划户数 ,
 plotRatio (number): 容积率 ,
 propertyCompany (string): 物业公司 ,
 propertyPrice (number): 物业费用 ,
 structureArea (number): 建筑面积 ,
 supplyElectricity (integer): 1民电2商电 ,
 supplyElectricityName (string): 1民电2商电 ,
 supplyHeating (integer): 1自供暖2集体供暖 ,
 supplyHeatingName (string): 1自供暖2集体供暖 ,
 supplyWater (integer): 1民水2商水 ,
 supplyWaterName (string): 1民水2商水 ,
 totalArea (number): 占地面积
 }NewHouseFormDTO {
 area (number, optional): 房屋建筑面积 ,
 contentImg (string): 内容照片 ,
 dealStatus (integer, optional): 1待售 2 在售 3售罄 ,
 dealStatusName (string, optional): 1待售 2 在售 3售罄 ,
 formImg (string): 户型照片 ,
 formType (string, optional): 几室几厅 ,
 formTypeOffice (integer): 厅 ,
 formTypeRoom (integer): 室 ,
 id (integer, optional),
 newHouseImgId (integer, optional): 相册名称 ,
 orientation (integer): 房子的朝向2朝南1朝东3朝西4朝北 ,
 purpose (integer, optional): 1普通住宅2商业类3别墅4四合院5车位6其他 ,
 totalPrice (number): 总价
 }NewHouseImgDTO {
 contentImg (Array[string], optional): 相册内容 ,
 forms (Array[NewHouseFormDTO], optional): 户型列表 ,
 id (integer, optional),
 imgType (integer, optional),
 name (string, optional): 相册名称 ,
 newHouseId (integer, optional)
 }NewHouseLicenceBasicDTO {
 binding (string): 绑定楼号 ,
 id (integer, optional),
 licence (string): 预售许可证 ,
 licenceDate (string): 发证时间 ,
 newHouseId (integer): 新房id
 }NewHouseSellBasicDTO {
 buildingCellNum (integer, optional): 楼栋数量 ,
 dealStatus (integer, optional): 1待售 2 在售 3售罄 ,
 dealStatusName (string, optional): 1待售 2 在售 3售罄 ,
 formNum (integer, optional): 户型数量 ,
 id (integer, optional),
 newHouseId (integer, optional),
 recentlyDeliverDate (string, optional): 最近交房时间 ,
 sellAddress (string, optional): 售楼地址 ,
 uptoDate (string, optional): 最新开盘时间
 }NewHouseBuildingCellInfoDTO {
 buildingCellId (integer, optional): 楼栋信息照片 ,
 buildingType (integer, optional): 1塔楼2板楼3板塔结合 ,
 buildingTypeName (string, optional): 1塔楼2板楼3板塔结合 ,
 cell (integer, optional): 多少单元 ,
 cellNum (integer, optional): 第几号楼 ,
 completionDate (string): 交房日期 ,
 floors (integer, optional): 层数 ,
 households (integer): 户数 ,
 id (integer, optional),
 openingDate (string): 开盘日期
 }
 */
