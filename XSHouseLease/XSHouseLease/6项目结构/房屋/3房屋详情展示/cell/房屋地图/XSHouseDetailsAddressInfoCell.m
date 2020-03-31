//
//  XSHouseDetailsAddressInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsAddressInfoCell.h"
#import "XSMapViewController.h"

@interface XSHouseDetailsAddressInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UIView *mapBkView;
@property (strong, nonatomic) XSMapViewController *mapVc;
@end

@implementation XSHouseDetailsAddressInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.locationLable.text = nil;
    UIView *view = self.mapVc.view;
    view.frame = self.mapBkView.bounds;
    
    [self.mapBkView addSubview:_mapVc.view];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
}
- (XSMapViewController *)mapVc{
    if (_mapVc == nil) {
        _mapVc = [[XSMapViewController alloc]init];
    }
    return _mapVc;
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        self.locationLable.text = [NSString stringWithFormat:@"%@/%@",dataModel.region,dataModel.town];
        self.mapVc.location = CLLocationCoordinate2DMake(dataModel.latitude.floatValue, dataModel.longitude.floatValue);

      }
}

@end
