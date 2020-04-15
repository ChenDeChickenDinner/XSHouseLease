//
//  XSHouseDetailsModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/04/11.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>





//户型列表
@interface XSHouseDetailsDataFormsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *formTypeOffice;//厅
@property (nonatomic, strong) NSNumber *formTypeRoom;//室
@property (nonatomic, copy) NSString *formType;// 几室几厅

@property (nonatomic, strong) NSNumber *area;//房屋建筑面积
@property (nonatomic, strong) NSNumber *totalPrice;//总价
@property (nonatomic, copy) NSString *formImg;//户型照片
@property (nonatomic, copy) NSString *contentImg;//内容照片
@property (nonatomic, strong) NSNumber *NewHouseImgId;// 相册名称

@property (nonatomic, copy) NSString *orientationName;//内容照片
@property (nonatomic, copy) NSArray<NSString *> *featurePointNames;//特色

@property (nonatomic, strong) NSNumber *orientation;//房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, strong) NSNumber *purpose;//1普通住宅2商业类3别墅4四合院5车位6其他
@property (nonatomic, strong) NSNumber *dealStatus;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSString *dealStatusName;//1待售 2 在售 3售罄
@end


//相册
@interface XSHouseDetailsDataImgsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *imgType;//
@property (nonatomic, strong) NSNumber *NewHouseId;//
@property (nonatomic, copy) NSString *name;//
@property (nonatomic, copy) NSArray<NSString *> *contentImg;//内容照片
@property (nonatomic, copy) NSArray<XSHouseDetailsDataFormsModel *> *forms;//户型列表

@end

//基本信息
@interface XSHouseDetailsDataBasicModel : NSObject

@property (nonatomic, copy) NSString *icon;//用户头像
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *customerId;//用户id
@property (nonatomic, copy) NSString *customerName;//用户名称
@property (nonatomic, copy) NSString *city;//
@property (nonatomic, strong) NSNumber *cityId;//
@property (nonatomic, strong) NSNumber *townId;//
@property (nonatomic, copy) NSString *address;//详细地址
@property (nonatomic, copy) NSString *region;//
@property (nonatomic, strong) NSNumber *estateId;//
@property (nonatomic, strong) NSNumber *regionId;//区id
@property (nonatomic, copy) NSString *town;//
@property (nonatomic, copy) NSString *estate;//
@property (nonatomic, strong) NSNumber *push;//

@property (nonatomic, copy) NSString *estateAlias;//小区别名
@property (nonatomic, strong) NSNumber *referUnitPrice;//参考均价
@property (nonatomic, strong) NSNumber *referTotalPrice;//参考总价格
@property (nonatomic, copy) NSString *developers;//开发商

@property (nonatomic, strong) NSNumber *minArea;//
@property (nonatomic, strong) NSNumber *maxArea;//最大房屋面积

@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;//维度

@property (nonatomic, copy) NSString *billingDate;//开盘日期
@property (nonatomic, strong) NSNumber *registration;//产权年限

@property (nonatomic, strong) NSNumber *finish;//1精装修2简装修3毛坯
@property (nonatomic, copy) NSString *finishName;//1精装修2简装修3毛坯
@property (nonatomic, strong) NSNumber *ownership;//1商品房2公房3经适房4其他
@property (nonatomic, copy) NSString *ownershipName;//1商品房2公房3经适房4其他
@property (nonatomic, strong) NSNumber *buildingType;//1塔楼2板楼3板塔结合
@property (nonatomic, copy) NSString *buildingTypeName;//1塔楼2板楼3板塔结合
@property (nonatomic, strong) NSNumber *dealStatus;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSString *dealStatusName;//交易状态 2 在售 3售罄 1待售
@property (nonatomic, strong) NSNumber *purpose;//1普通住宅2商业类3别墅4四合院5车位6其他
@property (nonatomic, copy) NSString *purposeName;//1普通住宅2商业类3别墅4四合院5车位6其他
@end

//基本销售信息
@interface XSHouseDetailsDataSellBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *NewHouseId;//
@property (nonatomic, strong) NSNumber *formNum;//户型数量
@property (nonatomic, strong) NSNumber *buildingCellNum;//楼栋数量
@property (nonatomic, strong) NSNumber *dealStatus;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSString *dealStatusName;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSString *sellAddress;//售楼地址
@property (nonatomic, copy) NSString *uptoDate;//最新开盘时间
@property (nonatomic, copy) NSString *recentlyDeliverDate;//最近交房时间
@end

//小区概况
@interface XSHouseDetailsDataEstateBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *NewHouseId;//

@property (nonatomic, copy) NSString *propertyCompany;//物业公司
@property (nonatomic, strong) NSNumber *greeningRatio;//绿化率
@property (nonatomic, strong) NSNumber *totalArea;//占地面积
@property (nonatomic, strong) NSNumber *structureArea;//建筑面积
@property (nonatomic, strong) NSNumber *planBuilding;//规划楼栋
@property (nonatomic, strong) NSNumber *propertyPrice;//物业费用
@property (nonatomic, strong) NSNumber *planHouse;//规划户数
@property (nonatomic, strong) NSNumber *plotRatio;//容积率
@property (nonatomic, copy) NSString *parkingRatio;//车位配比

@property (nonatomic, strong) NSNumber *supplyHeating;//1自供暖2集体供暖
@property (nonatomic, copy) NSString *supplyHeatingName;//1自供暖2集体供暖
@property (nonatomic, strong) NSNumber *supplyElectricity;//1民电2商电
@property (nonatomic, copy) NSString *supplyElectricityName;//1民电2商电
@property (nonatomic, strong) NSNumber *supplyWater;//1民水2商水
@property (nonatomic, copy) NSString *supplyWaterName;//1民水2商水

@end

//预售许可证
@interface XSHouseDetailsDataLicenceBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *NewHouseId;//
@property (nonatomic, copy) NSString *licenceDate;//发证时间
@property (nonatomic, copy) NSString *binding;//绑定楼号
@property (nonatomic, copy) NSString *licence;//预售许可证
@end


//楼栋信息
@interface XSHouseDetailsDataBuildingCellBasicInfosModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *floors;//层数
@property (nonatomic, strong) NSNumber *cellNum;//第几号楼
@property (nonatomic, strong) NSNumber *buildingCellId;//楼栋信息照片
@property (nonatomic, strong) NSNumber *cell;//多少单元
@property (nonatomic, strong) NSNumber *households;//户数
@property (nonatomic, strong) NSNumber *buildingType;//1塔楼2板楼3板塔结合
@property (nonatomic, copy) NSString *buildingTypeName;//1塔楼2板楼3板塔结合
@property (nonatomic, copy) NSString *completionDate;//交房日期
@property (nonatomic, copy) NSString *openingDate;// 开盘日期
@end
@interface XSHouseDetailsDataBuildingCellBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, copy) NSString *contentImg;//
@property (nonatomic, strong) NSNumber *NewHouseId;//新房id
@property (nonatomic, strong) NSNumber *dealStatus;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSString *dealStatusName;//1待售 2 在售 3售罄
@property (nonatomic, copy) NSArray<XSHouseDetailsDataBuildingCellBasicInfosModel *> *infos;//楼栋信息
@end

//动态信息
@interface XSHouseDetailsDataDynamicsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;//
@property (nonatomic, strong) NSNumber *NewHouseId;//新房id
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *publicDate;//发布时间
@property (nonatomic, strong) NSNumber *contentType;//1是销控信息2其他
@property (nonatomic, copy) NSString *contentTypeName;//销控信息
@end





@interface XSHouseDetailsDataModel : NSObject

@property (nonatomic, copy) NSString *icon;//
@property (nonatomic, copy) NSString *title;//
@property (nonatomic, copy) NSString *city;//
@property (nonatomic, strong) NSNumber *cityId;//
@property (nonatomic, copy) NSString *town;//
@property (nonatomic, strong) NSNumber *townId;//
@property (nonatomic, copy) NSString *estate;//
@property (nonatomic, strong) NSNumber *estateId;//
@property (nonatomic, copy) NSString *region;//
@property (nonatomic, strong) NSNumber *regionId;//
@property (nonatomic, strong) NSNumber *distance;//
@property (nonatomic, strong) NSNumber *latitude;//
@property (nonatomic, strong) NSNumber *longitude;//

@property (nonatomic, strong) NSNumber *watch;//
@property (nonatomic, strong) NSNumber *push;//
@property (nonatomic, strong) NSNumber *minArea;//最小房屋面积
@property (nonatomic, strong) NSNumber *maxArea;//最大房屋面积


@property (nonatomic, strong) NSNumber *customerId;//
@property (nonatomic, copy) NSString *callName;//
@property (nonatomic, copy) NSString *callPhone;//
@property (nonatomic, copy) NSString *firstImg;//
@property (nonatomic, copy) NSArray<NSString *> *contentImg;//
@property (nonatomic, copy) NSArray<NSNumber *> *featurePoints;//
@property (nonatomic, copy) NSArray<NSString *> *featurePointNames;//

@property (nonatomic, copy) NSString *billingDate;//开盘日期

@property (nonatomic, strong) NSNumber *dealStatus;//交易状态 2 在售 3售罄 1待售
@property (nonatomic, copy) NSString *dealStatusName;//1待售 2 在售 3售罄

@property (nonatomic, strong) NSNumber *purpose;//1普通住宅2商业类3别墅4四合院5车位6其他 ,
@property (nonatomic, copy) NSString *purposeName;//1普通住宅2商业类3别墅4四合院5车位6其他

@property (nonatomic, strong) NSNumber *formNum;//户型数量

@property (nonatomic, strong) NSNumber *imgNum;//更多相册的数量
@property (nonatomic, strong) NSNumber *referTotalPrice;//参考总价
@property (nonatomic, strong) NSNumber *referUnitPrice;//参考均价

@property (nonatomic, copy) NSArray<XSHouseDetailsDataImgsModel *> *imgs;//相册
@property (nonatomic, copy) NSArray<XSHouseDetailsDataFormsModel *> *forms;//户型列表
@property (nonatomic, copy) NSArray<XSHouseDetailsDataDynamicsModel *> *dynamics;//动态信息
@property (nonatomic, strong) XSHouseDetailsDataBasicModel *basic;//基本信息
@property (nonatomic, strong) XSHouseDetailsDataSellBasicModel *sellBasic;//基本销售信息
@property (nonatomic, strong) XSHouseDetailsDataEstateBasicModel *estateBasic;//小区概况
@property (nonatomic, strong) XSHouseDetailsDataLicenceBasicModel *licenceBasic;//预售许可证
@property (nonatomic, strong) XSHouseDetailsDataBuildingCellBasicModel *buildingCellBasic;//楼栋信息

@end






