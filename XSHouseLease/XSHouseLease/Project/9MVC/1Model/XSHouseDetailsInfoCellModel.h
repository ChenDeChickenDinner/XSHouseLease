//
//  XSHouseDetailsInfoCellModel.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBHouseInfoModel.h"
#import "XSHouseRentInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSHouseDetailsInfoCellModel : XSBHouseInfoModel
@property(nonatomic,strong)XSHouseRentInfoModel *dataModel;
@end

NS_ASSUME_NONNULL_END
