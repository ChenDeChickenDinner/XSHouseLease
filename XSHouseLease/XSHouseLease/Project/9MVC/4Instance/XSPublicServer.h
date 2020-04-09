//
//  XSPublicServer.h
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBaseServer.h"


//位置
@interface XSHouseLocationModel : NSObject
@property (nonatomic,copy) NSString *city;
@property (nonatomic,strong) NSNumber *cityId;
@property (nonatomic,copy) NSString *region;
@property (nonatomic,strong) NSNumber *regionId;
@property (nonatomic,copy) NSString *town;
@property (nonatomic,strong) NSNumber *townId;
+ (instancetype)LocationModelWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
@end

// bunner
@interface XSHousePicture : NSObject
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *order;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *updateDate;
@end
// 热搜
@interface XSHousehots : NSObject
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





@interface XSPublicServer : XSBaseServer
+ (XSPublicServer *)sharedInstance;

@property (strong, nonatomic) NSMutableArray<BRProvinceModel *> *cityArray;
@property (strong, nonatomic) NSMutableArray<XSHousehots *> *hotsSearchArray;
@property (strong, nonatomic) NSMutableArray<XSHousePicture *> *bunnerArray;
@property (strong, nonatomic) NSMutableArray<NSString *> *bunnerUrlArray;
- (void)cityTreeWithCallback:(HBCompletionBlock)callback;
- (void)bunnerListWithCallback:(HBCompletionBlock)callback;
- (void)hotsSearchWithCallback:(HBCompletionBlock)callback;


@end

