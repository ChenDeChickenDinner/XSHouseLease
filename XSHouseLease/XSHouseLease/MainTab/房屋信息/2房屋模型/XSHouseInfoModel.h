//
//  XSHouseInfoModel.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSHouseEnum.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,XSValueInputType) {
    XSValueInputType_textField = 0,
    XSValueInputType_listSelect,
    XSValueInputType_collectionview,
    XSValueInputType_textView,

};
typedef NS_ENUM(NSInteger,XSValueTextInputType) {
    XSValueTextInputType_Str = 0,
    XSValueTextInputType_Number,
    XSValueTextInputType_phone,

};
typedef NS_ENUM(NSInteger,XSValueSendType) {
    XSValueSendType_Int = 0,
    XSValueSendType_Str,
};
typedef void (^valueUpdate)(void);

@interface XSValue : XSBaseObject
//对应的key
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *keyStr;

//value值
@property (nonatomic,copy) NSNumber *value;
//value得含义表示
@property (nonatomic,copy) NSString *valueStr;
//是否被选中
@property (nonatomic,assign) BOOL isSelect;
//发送类型
@property (nonatomic,assign) XSValueSendType sendType;
//前描述
@property (nonatomic,copy) NSString *frontDescribe;
//后描述
@property (nonatomic,copy) NSString *hindDescribe;
//提示语
@property (nonatomic,copy) NSString *placeholder;

@property (nonatomic,copy) valueUpdate updateBlack;

@end

@interface XSKeyValueModel : XSBaseObject
//字段描述
@property (nonatomic,copy) NSString *name;

//字段key
@property (nonatomic,copy) NSString *key;

//字段values
@property (nonatomic,strong) NSArray<XSValue *> *values;
@property (nonatomic,copy) valueUpdate updateBlack;
//字段是否可以多选
@property (nonatomic,assign) BOOL moreSelect;

//字段展示的顺序位置
@property (nonatomic, strong) NSNumber *sequence;

//字段输入类型决定cell的布局
@property (nonatomic,assign) XSValueInputType keyInputType;
@property (nonatomic,assign) XSValueTextInputType keyTextInputType;


@end

@interface XSHouseInfoCellModel : XSBaseObject
//cell头部描述，如果values只有一个取value的name
@property (nonatomic,copy) NSString *title;
//cell包含的字段选项
@property (nonatomic,strong) NSArray<XSKeyValueModel *> *arrayValue;

//字段展示的顺序位置
@property (nonatomic, strong) NSNumber *sequence;

@property (nonatomic,copy) NSString *cellClass;

//cell的高度
@property (nonatomic,strong)  NSNumber *cellHeight;

- (instancetype)initwithEnumData:(XSHouseEnumData *)model;
@end



@interface XSHouseLocationModel : XSBaseObject

@property (nonatomic,copy) NSString *city;
@property (nonatomic,strong) NSNumber *cityId;

@property (nonatomic,copy) NSString *region;
@property (nonatomic,strong) NSNumber *regionId;

@property (nonatomic,copy) NSString *town;
@property (nonatomic,strong) NSNumber *townId;
+ (instancetype)LocationModelWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
@end


NS_ASSUME_NONNULL_END
