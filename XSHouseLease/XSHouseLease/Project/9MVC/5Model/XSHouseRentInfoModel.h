//
//  XSHouseRentInfoModel.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSHouseRentInfoModel.h"



@class XSBHouseInfoModel;
@class XSBusinessInfoModel;
@class XSHouseModuleModel;


//value发生set变化
typedef void (^XSValueUpdate)(void);


@interface XSValue : NSObject
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *keyStr;
@property (nonatomic,copy) NSNumber *value;
@property (nonatomic,copy) NSString *valueStr;
@property (nonatomic,copy) NSString *frontDescribe;
@property (nonatomic,copy) NSString *hindDescribe;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,copy) XSValueUpdate updateBlack;
@property (nonatomic,assign) XSValueSendType sendType;
@end

@interface XSKeyValueModel : NSObject
@property (nonatomic,copy)   NSString *name;
@property (nonatomic,copy)   NSString *key;
@property (nonatomic,assign) BOOL multiple;
@property (nonatomic,strong) NSNumber *sequence;
@property (nonatomic,strong) NSArray<XSValue *> *values;
@property (nonatomic,assign) XSValueInputType keyInputType;
@property (nonatomic,assign) XSValueTextInputType keyTextInputType;
@property (nonatomic,copy)   XSValueUpdate updateBlack;
@property (nonatomic,copy)   XSValuechangeStatus valuechangeStatus;
@end

//接口拉取的
@interface XSHouseEnumDataEnumRes : NSObject
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, copy  ) NSString *name;
@end
@interface XSHouseEnumData : NSObject
@property (nonatomic, copy) NSString *key;//选项值
@property (nonatomic, copy) NSString *name;//选项描述
@property (nonatomic, strong) NSNumber *type;//选项顺序位置
@property (nonatomic, assign) BOOL multiple;//是否可以多选
@property (nonatomic, copy) NSArray<XSHouseEnumDataEnumRes *> *enumRes;//可选项选项
@end

@interface XSHouseInfoCellModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSNumber *sequence;
@property (nonatomic,copy) NSString *cellClass;
@property (nonatomic,strong) NSNumber *cellHeight;
@property (nonatomic,strong) NSArray<XSKeyValueModel *> *arrayValue;
//根据接口配置数据生成
- (instancetype)initwithEnumData:(XSHouseEnumData *)model;
@end



@interface XSKeyValue : XSHouseInfoCellModel
@property(nonatomic,copy) NSString *key;
@property(nonatomic,copy) NSString *value;
@end













//
typedef void (^XSHouseInfoClickBlack)(XSBHouseInfoModel *model,XShouseOperation operation);

@interface XSBHouseInfoModel : NSObject
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,copy  ) XSHouseInfoClickBlack clickBlack;
@property(nonatomic,copy  ) clickEditStatus clickEditStatu;
@property(nonatomic,copy  ) NSString *cellClass;
@property(nonatomic,copy  ) XSValuechangeStatus valuechangeStatus;
@end


@interface XSHouseRentInfoModel : XSBHouseInfoModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL watch;
@property (nonatomic, strong) NSNumber *house_id;
@property (nonatomic, strong) NSNumber *customerId;
@property (nonatomic, copy) NSString *callPhone;
@property (nonatomic, copy) NSString *callName;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSNumber *cityId;//城市
@property (nonatomic, copy) NSString *region;// 区
@property (nonatomic, copy) NSString *town;// 镇
@property (nonatomic, strong) NSNumber *area;//面积
@property (nonatomic, copy) NSString *estate;//小区名字
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
@property (nonatomic, strong) NSNumber *dealStatus;// 0未出租1是已出租 ,
@property (nonatomic, copy) NSString *dealStatusName;// 名字0未出租1是已出租
@property (nonatomic, strong) NSNumber *rentTimeType;//租期类型
@property (nonatomic, copy) NSString *rentTimeTypeName;//租期类型年租
@property (nonatomic, strong) NSNumber *finish;//装修类型
@property (nonatomic, copy) NSString *finishName;//装修类型
@property (nonatomic, copy) NSArray<NSString *> *featurePointNames;//特色
@property (nonatomic, copy) NSArray<NSNumber *> *featurePoints;
@property (nonatomic, copy) NSArray<NSNumber *> *facilities;//配套设施
@property (nonatomic, copy) NSString *modelIntroduced;//这是卖点
@property (nonatomic, copy) NSString *transportation;//这是交通出行
@property (nonatomic, copy) NSString *estateIntroduced;//这是小区介绍
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, strong) NSNumber *watchNum;//关注人数
@property (nonatomic, copy) NSString *createDate;//创建时间
@property (nonatomic, copy) NSString *updateDate;//更新日期
//1待审核 能编辑 2审核失败 能编辑 3已取消 能编辑 可重新发布1 4下架 能编辑 5暂停 能编辑 可发布6 6发布 不能编辑  可取消3 可暂停5
@property (nonatomic, strong) NSNumber *status;

@end


@interface XSHouseDetailsInfoCellModel : XSBHouseInfoModel
@property(nonatomic,strong)XSHouseRentInfoModel *dataModel;
@end


