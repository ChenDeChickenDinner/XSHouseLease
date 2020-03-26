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

@interface XSHouseFixedData : XSBaseObject
+ (XSHouseFixedData *)sharedInstance;

// 城市数据
@property (strong, nonatomic) NSMutableArray<BRProvinceModel *> *cityArray;

@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *renthouseConditionArray;

// 租房提交信息
@property (strong, nonatomic) NSMutableDictionary *subRentParameterDict;

- (void)LocationParameterUpdateWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value;
@end

NS_ASSUME_NONNULL_END
