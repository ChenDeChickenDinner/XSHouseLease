//
//  XSBaseObject.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^clickEditStatus)(NSNumber *status,NSNumber *houseID);
typedef void(^searchBlack)(NSString *searhKey);

@interface XSBaseObject : NSObject

@end

NS_ASSUME_NONNULL_END
