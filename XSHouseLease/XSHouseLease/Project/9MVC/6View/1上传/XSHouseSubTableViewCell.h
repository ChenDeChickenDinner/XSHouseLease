//
//  XSHouseSubTableViewCell.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseRentInfoModel.h"


@interface XSCollectionViewCell :  UICollectionViewCell
@property(nonatomic,strong) XSValue *valueModel;
- (void)refreshData;
@end

@interface XSHouseSubTableViewCell : UITableViewCell
@property(nonatomic,strong) XSHouseInfoCellModel *dataModel;
- (void)refreshData;
@end


@interface XSHouseSubListChooseTableViewCell : XSHouseSubTableViewCell


@end

@interface XSHouseSubTextFieldTableViewCell : XSHouseSubTableViewCell

@end

@interface XSHouseSubTextViewCell : XSHouseSubTableViewCell

@end

@interface XSHouseSubCollectionviewACell : XSHouseSubTableViewCell

@end

@interface XSHouseSubCollectionviewBCell : XSHouseSubTableViewCell

@end




