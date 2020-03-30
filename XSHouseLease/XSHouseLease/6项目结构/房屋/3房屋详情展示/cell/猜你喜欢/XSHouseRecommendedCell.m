//
//  XSHouseRecommendedCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseRecommendedCell.h"

#import "XSHouseInfoTableView.h"
#import "XSHouseRentInfoModel.h"
#import "XSHouseDetailsController.h"
#import "XSMyPublishHosueController.h"

@interface XSHouseRecommendedCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listHeight;
@property (nonatomic,strong) XSHouseInfoTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bkView;


@property (strong, nonatomic)  XSMyPublishHosueController *listvc;

@end

@implementation XSHouseRecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.source = XSBHouseInfoSource_MyPush;
    listvc.view.frame = self.bkView.bounds;
    self.listvc =listvc;
    [self.bkView addSubview:listvc.view];

//    XSHouseInfoTableView *tableView = [[XSHouseInfoTableView alloc]init];
//      tableView.mj_header.automaticallyChangeAlpha = YES;
//      tableView.mj_footer.automaticallyChangeAlpha = YES;
//      [self.bkView addSubview:tableView];
//      self.tableView = tableView;

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.listvc.view.frame = self.bkView.bounds;
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        self.listvc.house_id = dataModel.house_id;
        [self.listvc loadData];
      }
}
- (IBAction)more:(id)sender {
    XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)self.model;
     XSHouseRentInfoModel *dataModel = cellModel.dataModel;
    
    XSMyPublishHosueController *listvc = [[XSMyPublishHosueController alloc]init];
    listvc.source = XSBHouseInfoSource_MyPush;
    listvc.house_id = dataModel.house_id;
    [[NSObject getTopViewController].navigationController pushViewController:listvc animated:YES];
}

@end
