//
//  XSConfigServer.h
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSHouseInfoShowModel.h"

@class XSBHouseInfoModel;
@class XSBusinessInfoModel;
@class XSHouseModuleModel;

typedef void (^businessInfoClickBlack)(XSBusinessInfoModel *model);
typedef void (^clickBlack)(XSHouseModuleModel *model);

// 上传



// 配套设施
@interface XSHouseDetailsFacilitiesModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *updateDate;
@end


@interface XSBusinessInfoJsonModel : NSObject
@property (nonatomic, copy  ) NSString *key;
@property (nonatomic, strong) NSNumber *keyType;
@property (nonatomic, copy  ) NSString *keyName;
@end


@interface XSBusinessInfoModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) businessInfoClickBlack clickBlack;
@end



// 搜索
@interface XSHouseModuleModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong)NSNumber *value;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) clickBlack clickBlack;
@end

@interface XSConfigServer : NSObject
+ (XSConfigServer *)sharedInstance;
//详情中信息B的展示 配的固定Json
@property (strong, nonatomic) NSMutableArray<XSBusinessInfoJsonModel *> *businessInfoArray;
//配套设施
@property (strong, nonatomic) NSMutableArray<XSHouseDetailsFacilitiesModel *> *facilitiesInfoArray;
//搜索条件
@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *renthouseConditionArray;
@end




