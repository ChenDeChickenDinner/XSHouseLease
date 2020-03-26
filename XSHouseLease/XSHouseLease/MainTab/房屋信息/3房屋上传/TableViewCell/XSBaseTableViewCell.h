//
//  XSBaseTableViewCell.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSBaseTableViewCell : UITableViewCell
@property(nonatomic,strong) XSValue *valueModel;
+ (instancetype)cellWithtableView:(UITableView *)tableView;
- (void)refreshData;
@end

NS_ASSUME_NONNULL_END
