//
//  XSHouseCallMessageCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseCallMessageCell.h"

@implementation XSHouseCallMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
          
      }
}

@end
