//
//  XSBusinessInfoSever.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"
#import "XSBusinessInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSBusinessInfoSever : XSBaseObject
+ (XSBusinessInfoSever *)sharedInstance;
@property (strong, nonatomic) NSMutableArray<XSBusinessInfoJsonModel *> *businessInfoArray;
@property (strong, nonatomic) NSMutableArray<XSHouseDetailsFacilitiesModel *> *facilitiesInfoArray;

@end

NS_ASSUME_NONNULL_END
