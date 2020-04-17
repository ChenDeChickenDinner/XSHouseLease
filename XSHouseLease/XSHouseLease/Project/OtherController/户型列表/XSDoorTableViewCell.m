//
//  XSDoorTableViewCell.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSDoorTableViewCell.h"
@interface XSDoorTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *MyimageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *bkView;

@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablea;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLableb;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablec;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLableaW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablebW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablecW;

@end
@implementation XSDoorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.text = @"";
    self.info.text = @"";
    self.price.text = @"";
    self.featurePointsLablea.text = nil;
    self.featurePointsLableb.text = nil;
    self.featurePointsLablec.text = nil;
    self.featurePointsLableaW.constant = 0;
    self.featurePointsLablebW.constant = 0;
    self.featurePointsLablecW.constant = 0;
}


- (void)setDataModel:(XSHouseDetailsDataFormsModel *)dataModel{
    _dataModel = dataModel;
    self.title.text = dataModel.formType;
    self.info.text = [NSString stringWithFormat:@"建面%@m2 %@",dataModel.area,dataModel.orientationName];
    self.price.text = [NSString stringWithFormat:@"约%@万/套",dataModel.totalPrice];
    [self.MyimageView sd_setImageWithURL:[NSURL URLWithString:dataModel.formImg]];
    
    NSString *stra = [dataModel.featurePointNames safeObjectAtIndex:0];;
    NSString *strb = [dataModel.featurePointNames safeObjectAtIndex:1];;
    NSString *strc = [dataModel.featurePointNames safeObjectAtIndex:2];;
    self.featurePointsLablea.text = stra;
    self.featurePointsLableb.text = strb;
    self.featurePointsLablec.text = strc;
    self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
    self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
    self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;
    
}
@end
