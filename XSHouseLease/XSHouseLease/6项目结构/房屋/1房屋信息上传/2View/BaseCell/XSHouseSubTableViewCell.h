//
//  XSHouseSubTableViewCell.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseInfoModel.h"
#import "XSBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSHouseSubTableViewCell : UITableViewCell

@property(nonatomic,strong) XSHouseInfoCellModel *dataModel;
@property (nonatomic,strong) XSHouseInfoCellModel *keyValueModel;

+ (instancetype)cellWithtableView:(UITableView *)tableView;
- (void)refreshData;
@end

NS_ASSUME_NONNULL_END


@interface XSCollectionViewCell :  XSBaseCollectionViewCell

@end

