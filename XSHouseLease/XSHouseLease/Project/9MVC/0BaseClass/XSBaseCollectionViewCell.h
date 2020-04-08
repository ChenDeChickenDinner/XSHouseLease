//
//  XSBaseCollectionViewCell.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseRentInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSBaseCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) XSValue *valueModel;
- (void)refreshData;
@end

NS_ASSUME_NONNULL_END
