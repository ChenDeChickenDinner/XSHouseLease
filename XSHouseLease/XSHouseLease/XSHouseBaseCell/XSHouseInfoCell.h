//
//  XSHouseInfoCell.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSBHouseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSHouseInfoCell : UITableViewCell
@property(nonatomic,strong)XSBHouseInfoModel *model;

+ (instancetype)cellWithtableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
