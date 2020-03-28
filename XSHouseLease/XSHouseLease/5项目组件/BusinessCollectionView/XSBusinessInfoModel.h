//
//  XSBusinessInfoModel.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@class XSBusinessInfoModel;
typedef void (^businessInfoClickBlack)(XSBusinessInfoModel *model);

@interface XSBusinessInfoJsonModel : XSBaseObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSNumber *keyType;
@property (nonatomic, copy) NSString *keyName;

@end
@interface XSBusinessInfoModel : XSBaseObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) businessInfoClickBlack clickBlack;

@end

NS_ASSUME_NONNULL_END
