//
//  XSHouseInfoShowModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSPublicServer.h"
#import "XSHouseDetailsModel.h"
#import "XSHouseEnum.h"



@class XSHouseInfoModel;

//更改房屋状态
typedef void(^clickEditStatus)(NSNumber *status,NSNumber *houseID);
typedef void(^XSHouseInfoClickBlack)(XSHouseInfoModel *model,id data,XSBHouseKeyValueEditStatus editStatus);


@interface XSHouseEsModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) NSNumber *regionId;
@property (nonatomic, strong) NSNumber *townId;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *estateId;
@property (nonatomic, strong) NSNumber *hot;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@end


@interface XSHouseInfoModel : NSObject
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,copy  ) clickEditStatus clickEditStatu;
@property(nonatomic,copy  ) XSHouseInfoClickBlack clickBlack;
@property(nonatomic,copy  ) NSString *cellClass;
@property (nonatomic,strong) NSNumber *cellHeight;
@end
@interface XSHouseInfoShowModel : XSHouseInfoModel
@property(nonatomic,assign) XSHouseSource resource;
@property (nonatomic, copy) NSString *resourceName;

@property (nonatomic, strong) NSNumber *dealStatus;// 0未出租1是已出租 , (2 在售 3售罄 1待售)
@property (nonatomic, copy) NSString *dealStatusName;// 名字0未出租1是已出租

//发布
//1待审核 能编辑 2审核失败 能编辑 3已取消 能编辑 可重新发布1 4下架 能编辑 5暂停 能编辑 可发布6 6发布 不能编辑  可取消3 可暂停5
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *statusName;

@property (nonatomic, assign) BOOL watch;
@property (nonatomic, strong) NSNumber *watchNum;//关注人数

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleDetail;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSNumber *house_id;
@property (nonatomic, strong)NSNumber *customerId;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *callPhone;
@property (nonatomic, copy) NSString *callName;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) NSNumber *regionId;
@property (nonatomic, copy) NSString *town;
@property (nonatomic, strong) NSNumber *townId;
@property (nonatomic, copy) NSString *estate;
@property (nonatomic, strong) NSNumber *estateId;
@property (nonatomic, strong) XSHouseEsModel *es;

@property (nonatomic, strong) NSNumber *area;//面积
@property (nonatomic, copy) NSString *address;//详细地址
@property (nonatomic, strong) NSNumber *rentPrice;//租金
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;// 维度
@property (nonatomic, strong) NSNumber *distance;//距离范围
@property (nonatomic, strong) NSNumber *rentWay;//出租方式
@property (nonatomic, copy) NSString *rentWayName;//出租方式整租
@property (nonatomic, copy) NSString *firstImg;//封面图
@property (nonatomic, copy) NSArray<NSString *> *contentImg;//房屋图骗
@property (nonatomic, strong) NSNumber *formTypeOffice;// 厅
@property (nonatomic, strong) NSNumber *formTypeRoom;// 室
@property (nonatomic, copy) NSString *formType;// 几室几厅
@property (nonatomic, strong) NSNumber *orientation;// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, copy) NSString *orientationName;// 房子的朝向2朝南1朝东3朝西4朝北
@property (nonatomic, strong) NSNumber *floor;//楼层
@property (nonatomic, strong) NSNumber *totalFloor;//总楼层
@property (nonatomic, strong) NSNumber *seeHouseType;//看房方式 随时 约看
@property (nonatomic, copy) NSString *seeHouseTypeName;
@property (nonatomic, strong) NSNumber *inDay;//入住时间
@property (nonatomic, copy) NSString *inDayName;//入住时间 近20天内
@property (nonatomic, strong) NSNumber *elevator;//是否有电梯
@property (nonatomic, strong) NSNumber *waterElectricity;//水电类型
@property (nonatomic, copy) NSString *waterElectricityName;//水电类型

@property (nonatomic, strong) NSNumber *rentTimeType;//租期类型
@property (nonatomic, copy) NSString *rentTimeTypeName;//租期类型年租
@property (nonatomic, strong) NSNumber *finish;//装修类型
@property (nonatomic, copy) NSString *finishName;//装修类型
@property (nonatomic, copy) NSArray<NSString *> *featurePointNames;//特色
@property (nonatomic, copy) NSArray<NSNumber *> *featurePoints;
@property (nonatomic, copy) NSArray<NSNumber *> *facilities;//配套设施
@property (nonatomic, copy) NSString *coreIntroduced;//这是卖点
@property (nonatomic, copy) NSString *transportation;//这是交通出行
@property (nonatomic, copy) NSString *estateIntroduced;//这是小区介绍
@property (nonatomic, copy) NSString *createDate;//创建时间
@property (nonatomic, copy) NSString *updateDate;//更新日期









//二手
@property (nonatomic, strong) NSNumber *push;//
@property (nonatomic, strong) NSNumber *unitPrice;//单价
@property (nonatomic, strong) NSNumber *totalPrice;// 总价
@property (nonatomic, strong) NSNumber *createYears;//建成年代
@property (nonatomic, strong) NSNumber *form;//户型结构
@property (nonatomic, strong) NSNumber *realityArea;//房屋实际面积
@property (nonatomic, strong) NSNumber *elevatorDoor;// 梯户比例

@property (nonatomic, copy) NSString *formName;//户型结构
@property (nonatomic, copy) NSString *modelImg;//户型图
@property (nonatomic, copy) NSString *hangoutDate;//挂牌时间
@property (nonatomic, copy) NSString *modelIntroduced;//户型介绍
@property (nonatomic, copy) NSString *elevatorName;//
@property (nonatomic, strong) NSNumber *buildingType;//1塔楼2板楼3板塔结合
@property (nonatomic, copy) NSString *buildingTypeName;// 1塔楼2板楼3板塔结合
@property (nonatomic, strong) NSNumber *pledge;//1有抵押 0是无
@property (nonatomic, copy) NSString *pledgeName;//1有抵押 0是无
@property (nonatomic, strong) NSNumber *floorLocaltion;//楼层所在的位置
@property (nonatomic, copy) NSString *floorLocaltionName;//楼层所在的位置
@property (nonatomic, strong) NSNumber *ownership;//1商品房2公房3经适房4其他
@property (nonatomic, copy) NSString *ownershipName;//1商品房2公房3经适房4其他
@property (nonatomic, strong) NSNumber *supplyHeating;//1自供暖2集体供暖
@property (nonatomic, copy) NSString *supplyHeatingName;//1自供暖2集体供暖
@property (nonatomic, strong) NSNumber *purpose;//1普通住宅2商业类3别墅4四合院5车位6其他
@property (nonatomic, copy) NSString *purposeName;//1普通住宅2商业类3别墅4四合院5车位6其他
@property (nonatomic, strong) NSNumber *fiveYears;//是否满五年
@property (nonatomic, copy) NSString *fiveYearsName;//是否满五年


//新房
@property (nonatomic, strong) NSNumber *minArea;//建筑面积
@property (nonatomic, strong) NSNumber *maxArea;//建筑面积
@property (nonatomic, strong) NSNumber *referTotalPrice;
@property (nonatomic, strong) NSNumber *referUnitPrice;
@property (nonatomic, copy) NSString *billingDate;//开盘日期
@property (nonatomic, strong) NSNumber *formNum;//户型数量
@property (nonatomic, strong) NSNumber *imgNum;//更多相册的数量


@property (nonatomic, copy) NSArray<XSHouseDetailsDataImgsModel *> *imgs;//相册
@property (nonatomic, copy) NSArray<XSHouseDetailsDataFormsModel *> *forms;//户型列表
@property (nonatomic, copy) NSArray<XSHouseDetailsDataDynamicsModel *> *dynamics;//动态信息
@property (nonatomic, strong) XSHouseDetailsDataBasicModel *basic;//基本信息
@property (nonatomic, strong) XSHouseDetailsDataSellBasicModel *sellBasic;//基本销售信息
@property (nonatomic, strong) XSHouseDetailsDataEstateBasicModel *estateBasic;//小区概况
@property (nonatomic, strong) XSHouseDetailsDataLicenceBasicModel *licenceBasic;//预售许可证
@property (nonatomic, strong) XSHouseDetailsDataBuildingCellBasicModel *buildingCellBasic;//楼栋信息

-(XSHouseKeyValueModuleModel *)houseInfoBArrayWithSourceType:(XSBHouseKeyValueDataSource)type sourceDict:(NSMutableDictionary *)sourceDict;
@end







