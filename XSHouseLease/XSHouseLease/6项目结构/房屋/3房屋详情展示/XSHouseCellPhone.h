//
//  XSHouseCellPhone.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSHouseCallPhone : UIView
+ (instancetype)callPhoneViewWithFrame:(CGRect)frame house_id:(NSNumber *)house_id;
- (void)upDataWithDataModel:(XSHouseRentInfoModel *)dataModel;
@end

NS_ASSUME_NONNULL_END
