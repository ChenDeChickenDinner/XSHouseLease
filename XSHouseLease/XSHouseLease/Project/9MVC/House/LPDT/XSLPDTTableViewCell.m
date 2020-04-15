//
//  XSLPDTTableViewCell.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSLPDTTableViewCell.h"
@interface XSLPDTTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation XSLPDTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.time.text = nil;
    self.title.text = nil;
    self.content.text = nil;

}

- (void)setDataModel:(XSHouseDetailsDataDynamicsModel *)dataModel{
    _dataModel = dataModel;
    self.time.text = dataModel.publicDate;
    self.title.text = dataModel.contentTypeName;;
    self.content.text = dataModel.content;;
}

@end
