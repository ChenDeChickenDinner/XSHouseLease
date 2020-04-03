//
//  XSBusinessCollectionCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBusinessCollectionCell.h"
@interface XSBusinessCollectionCell ()

@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *contentLable;

@end

@implementation XSBusinessCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];

        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.textAlignment = NSTextAlignmentLeft;

        titleLable.textColor = [UIColor hb_colorWithHexString:@"#BFBFBF" alpha:1];
         [self.contentView addSubview:titleLable];
          self.titleLable = titleLable;
        
        UILabel *contentLable = [[UILabel alloc] init];
         contentLable.backgroundColor = [UIColor clearColor];
         contentLable.font = [UIFont systemFontOfSize:14];
         contentLable.textAlignment = NSTextAlignmentLeft;

         contentLable.textColor = [UIColor hb_colorWithHexString:@"#1A1A1A" alpha:1];
          [self.contentView addSubview:contentLable];
          self.contentLable = contentLable;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLable.frame = CGRectMake(0, 0, 45, self.height);
    self.contentLable.frame = CGRectMake(45, 0, self.width - 45, self.height);
}
- (void)setModel:(XSBusinessInfoModel *)model{
    _model = model;
    self.titleLable.text = model.name;
    self.contentLable.text = model.value;
}
@end
