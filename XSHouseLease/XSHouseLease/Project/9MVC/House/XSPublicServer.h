//
//  XSPublicServer.h
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBaseServer.h"
@class XSHouseModuleModel;
typedef void (^clickBlack)(XSHouseModuleModel *model);


#pragma mark - 位置
@interface XSHouseLocationModel : NSObject
@property (nonatomic,copy) NSString *city;
@property (nonatomic,strong) NSNumber *cityId;
@property (nonatomic,copy) NSString *region;
@property (nonatomic,strong) NSNumber *regionId;
@property (nonatomic,copy) NSString *town;
@property (nonatomic,strong) NSNumber *townId;
+ (instancetype)LocationModelWithProvince:(BRProvinceModel *)province city:(BRCityModel *)city area:(BRAreaModel *)area;
@end

#pragma mark - bunner
@interface XSHousePicture : NSObject
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *order;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *updateDate;
@end
#pragma mark - 热搜
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

#pragma mark - KeyVlaue
@interface XSHouseKeyVlaueModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *keyName;
@property (nonatomic, copy) NSString *value;
@end

#pragma mark - 配套
@interface XSHouseFacilitiesModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *updateDate;
@end

#pragma mark -  搜索
@interface XSHouseModuleModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong)NSNumber *value;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) clickBlack clickBlack;
@end

@interface XSPublicServer : XSBaseServer
+ (XSPublicServer *)sharedInstance;

@property (strong, nonatomic) NSMutableArray<BRProvinceModel *> *cityArray;
@property (strong, nonatomic) NSMutableArray<XSHousehots *> *hotsSearchArray;
@property (strong, nonatomic) NSMutableArray<XSHousePicture *> *bunnerArray;
@property (strong, nonatomic) NSMutableArray<NSString *> *bunnerUrlArray;

@property (strong, nonatomic) NSMutableArray<XSHouseFacilitiesModel *> *facilitiesArray;
@property (strong, nonatomic) NSMutableArray<XSHouseKeyVlaueModel *> *rentHouseInfoBArray;
@property (strong, nonatomic) NSMutableArray<XSHouseKeyVlaueModel *> *secondHouseInfoBArray;

@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *renthouseConditionArray;
@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *newhouseConditionArray;
@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *secondhouseConditionArray;

- (void)cityTreeWithCallback:(HBCompletionBlock)callback;
- (void)bunnerListWithCallback:(HBCompletionBlock)callback;
- (void)hotsSearchWithCallback:(HBCompletionBlock)callback;
- (void)enumFacilitiesWithCallback:(HBCompletionBlock)callback;
- (void)renthouseConditionWithCallback:(HBCompletionBlock)callback;
@end

