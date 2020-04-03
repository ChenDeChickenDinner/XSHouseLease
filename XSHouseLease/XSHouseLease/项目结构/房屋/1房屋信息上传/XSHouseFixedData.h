//
//  XSHouseFixedData.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/25.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSHouseEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSHousePicture : XSBaseObject
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *order;

@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *updateDate;
@end
@interface XSHousehots : XSBaseObject
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *cityId;
@property (strong, nonatomic) NSNumber *townId;
@property (strong, nonatomic) NSNumber *regionId;
@property (strong, nonatomic) NSNumber *hot;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;


@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@end

@interface XSHouseFixedData : XSBaseObject
+ (XSHouseFixedData *)sharedInstance;

// 城市数据
@property (strong, nonatomic) NSMutableArray<BRProvinceModel *> *cityArray;

@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *renthouseConditionArray;

// 租房提交信息
@property (strong, nonatomic) NSMutableDictionary *subRentParameterDict;

@property (strong, nonatomic) NSMutableArray<XSHousePicture *> *bunnerArray;
@property (strong, nonatomic) NSMutableArray<NSString *> *bunnerUrlArray;
@property (strong, nonatomic) NSMutableArray<XSHousehots *> *hotsSearchArray;

- (void)LocationParameterUpdateWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value;
@end

NS_ASSUME_NONNULL_END
