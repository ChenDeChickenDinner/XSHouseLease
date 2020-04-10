//
//  XSBaseCollectionViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/24.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTableViewCell.h"




@interface XSCollectionViewCell ()
@property (weak, nonatomic)  UILabel *textlabel;

@end
@implementation XSCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;;
        label.layer.cornerRadius = 5;
        label.layer.borderWidth = 0.5;
        [self.contentView addSubview:label];
         self.textlabel = label;
    }
    return self;
}
- (void)layoutSubviews{
    self.textlabel.frame = self.bounds;
}
- (void)refreshData{
    self.textlabel.text = self.valueModel.valueStr;
    if (self.valueModel.isSelect) {
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#FFFFFF" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1].CGColor;
    }else{
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1].CGColor;
    }
}

@end
