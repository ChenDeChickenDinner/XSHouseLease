//
//  XSDoorCollectionViewCell.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSDoorCollectionViewCell.h"




@implementation XSDoorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.text = @"";
    self.info.text = @"";
    self.price.text = @"";
}


- (void)setDataModel:(XSHouseDetailsDataFormsModel *)dataModel{
    _dataModel = dataModel;
    self.title.text = dataModel.formType;
    self.info.text = [NSString stringWithFormat:@"建面%@m2 %@",dataModel.area,dataModel.orientationName];
    self.price.text = [NSString stringWithFormat:@"约%@万/套",dataModel.totalPrice];
    [self.MyimageView sd_setImageWithURL:[NSURL URLWithString:dataModel.formImg]];

    
}
@end
