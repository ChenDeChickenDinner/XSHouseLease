//
//  XSHouseDetailsAddressInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsAddressInfoCell.h"
@interface XSHouseDetailsAddressInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *locationLable;

@end

@implementation XSHouseDetailsAddressInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.locationLable.text = nil;
}

- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        self.locationLable.text = [NSString stringWithFormat:@"%@/%@",dataModel.region,dataModel.town];
      }
}

@end
