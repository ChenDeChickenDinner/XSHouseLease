//
//  XSHouseDetailsModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/04/11.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>



//基本信息
@interface XSHouseDetailsDataBasicModel : NSObject
@property (nonatomic, strong) NSNumber *dealStatus;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) NSNumber *maxArea;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *townId;
@property (nonatomic, strong) NSNumber *buildingType;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSNumber *ownership;
@property (nonatomic, strong) NSNumber *customerId;
@property (nonatomic, strong) NSNumber *registration;
@property (nonatomic, strong) NSNumber *minArea;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *estate;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *estateId;
@property (nonatomic, copy) NSString *finishName;
@property (nonatomic, copy) NSString *billingDate;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSNumber *referUnitPrice;
@property (nonatomic, copy) NSString *town;
@property (nonatomic, copy) NSString *developers;
@property (nonatomic, strong) NSNumber *push;
@property (nonatomic, strong) NSNumber *finish;
@property (nonatomic, copy) NSString *estateAlias;
@property (nonatomic, copy) NSString *ownershipName;
@property (nonatomic, copy) NSString *buildingTypeName;
@property (nonatomic, strong) NSNumber *purpose;
@property (nonatomic, strong) NSNumber *regionId;
@property (nonatomic, strong) NSNumber *referTotalPrice;
@property (nonatomic, copy) NSString *dealStatusName;
@property (nonatomic, copy) NSString *purposeName;
@property (nonatomic, strong) NSNumber *latitude;
@end

//基本销售信息
@interface XSHouseDetailsDataSellBasicModel : NSObject
@property (nonatomic, strong) NSNumber *dealStatus;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *buildingCellNum;
@property (nonatomic, strong) NSNumber *formNum;
@property (nonatomic, copy) NSString *dealStatusName;
@property (nonatomic, strong) NSNumber *NewHouseId;
@property (nonatomic, copy) NSString *sellAddress;
@property (nonatomic, copy) NSString *uptoDate;
@property (nonatomic, copy) NSString *recentlyDeliverDate;
@end

//小区概况
@interface XSHouseDetailsDataEstateBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *propertyCompany;
@property (nonatomic, strong) NSNumber *greeningRatio;
@property (nonatomic, strong) NSNumber *totalArea;
@property (nonatomic, strong) NSNumber *structureArea;
@property (nonatomic, strong) NSNumber *planBuilding;
@property (nonatomic, strong) NSNumber *supplyHeating;
@property (nonatomic, copy) NSString *supplyElectricityName;
@property (nonatomic, strong) NSNumber *propertyPrice;
@property (nonatomic, strong) NSNumber *supplyElectricity;
@property (nonatomic, strong) NSNumber *supplyWater;
@property (nonatomic, strong) NSNumber *NewHouseId;
@property (nonatomic, copy) NSString *supplyWaterName;
@property (nonatomic, strong) NSNumber *planHouse;
@property (nonatomic, copy) NSString *supplyHeatingName;
@property (nonatomic, strong) NSNumber *plotRatio;
@property (nonatomic, copy) NSString *parkingRatio;
@end

//预售许可证
@interface XSHouseDetailsDataLicenceBasicModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *licenceDate;
@property (nonatomic, copy) NSString *binding;
@property (nonatomic, strong) NSNumber *NewHouseId;
@property (nonatomic, copy) NSString *licence;
@end


//楼栋信息
@interface XSHouseDetailsDataBuildingCellBasicInfosModel : NSObject
@property (nonatomic, strong) NSNumber *floors;
@property (nonatomic, strong) NSNumber *cellNum;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *buildingCellId;
@property (nonatomic, strong) NSNumber *cell;
@property (nonatomic, strong) NSNumber *households;
@property (nonatomic, strong) NSNumber *buildingType;
@property (nonatomic, copy) NSString *buildingTypeName;
@property (nonatomic, copy) NSString *completionDate;
@property (nonatomic, copy) NSString *openingDate;
@end

//楼栋信息
@interface XSHouseDetailsDataBuildingCellBasicModel : NSObject
@property (nonatomic, strong) NSNumber *dealStatus;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *contentImg;
@property (nonatomic, strong) NSNumber *NewHouseId;
@property (nonatomic, copy) NSArray<XSHouseDetailsDataBuildingCellBasicInfosModel *> *infos;//楼栋信息
@property (nonatomic, copy) NSString *dealStatusName;
@end

//动态信息
@interface XSHouseDetailsDataDynamicsModel : NSObject
@property (nonatomic, copy) NSString *contentTypeName;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *publicDate;
@property (nonatomic, strong) NSNumber *contentType;
@property (nonatomic, strong) NSNumber *NewHouseId;
@end

//相册
@interface XSHouseDetailsDataImgsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *imgType;
@property (nonatomic, copy) NSArray<NSString *> *contentImg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *NewHouseId;
@property (nonatomic, copy) NSArray *forms;
@end


//户型列表
@interface XSHouseDetailsDataFormsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *formTypeOffice;
@property (nonatomic, strong) NSNumber *orientation;
@property (nonatomic, copy) NSString *contentImg;
@property (nonatomic, copy) NSString *formImg;
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, copy) NSString *formType;
@property (nonatomic, strong) NSNumber *formTypeRoom;
@property (nonatomic, strong) NSNumber *purpose;
@property (nonatomic, strong) NSNumber *dealStatus;
@property (nonatomic, strong) NSNumber *totalPrice;
@property (nonatomic, strong) NSNumber *NewHouseImgId;
@property (nonatomic, copy) NSString *dealStatusName;
@end





@interface XSHouseDetailsDataModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *town;
@property (nonatomic, strong) NSNumber *townId;
@property (nonatomic, copy) NSString *estate;
@property (nonatomic, strong) NSNumber *estateId;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) NSNumber *regionId;

@property (nonatomic, strong) NSNumber *customerId;
@property (nonatomic, copy) NSString *callName;
@property (nonatomic, copy) NSString *callPhone;
@property (nonatomic, copy) NSString *firstImg;
@property (nonatomic, copy) NSArray<NSString *> *contentImg;
@property (nonatomic, copy) NSArray<NSNumber *> *featurePoints;
@property (nonatomic, copy) NSArray<NSString *> *featurePointNames;

@property (nonatomic, copy) NSString *billingDate;
@property (nonatomic, copy) NSString *dealStatusName;
@property (nonatomic, copy) NSString *purposeName;

@property (nonatomic, strong) NSNumber *dealStatus;
@property (nonatomic, strong) NSNumber *maxArea;
@property (nonatomic, strong) NSNumber *formNum;
@property (nonatomic, strong) NSNumber *watch;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *minArea;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *referUnitPrice;
@property (nonatomic, strong) NSNumber *push;
@property (nonatomic, strong) NSNumber *purpose;
@property (nonatomic, strong) NSNumber *imgNum;
@property (nonatomic, strong) NSNumber *referTotalPrice;

@property (nonatomic, copy) NSArray<XSHouseDetailsDataImgsModel *> *imgs;//相册
@property (nonatomic, copy) NSArray<XSHouseDetailsDataFormsModel *> *forms;//户型列表

@property (nonatomic, strong) XSHouseDetailsDataBasicModel *basic;//基本信息
@property (nonatomic, strong) XSHouseDetailsDataSellBasicModel *sellBasic;//基本销售信息
@property (nonatomic, strong) XSHouseDetailsDataEstateBasicModel *estateBasic;//小区概况
@property (nonatomic, strong) XSHouseDetailsDataLicenceBasicModel *licenceBasic;//预售许可证

@property (nonatomic, strong) XSHouseDetailsDataBuildingCellBasicModel *buildingCellBasic;//楼栋信息
@property (nonatomic, copy) NSArray<XSHouseDetailsDataDynamicsModel *> *dynamics;//动态信息




@end






