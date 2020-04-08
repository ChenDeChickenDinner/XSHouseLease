//
//  XSBusinessInfoSever.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSHouseRentInfoModel.h"









@interface XSHouseFixedData : NSObject
+ (XSHouseFixedData *)sharedInstance;





@property (strong, nonatomic) NSMutableDictionary *subRentParameterDict;


- (void)LocationParameterUpdateWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value;
@end


