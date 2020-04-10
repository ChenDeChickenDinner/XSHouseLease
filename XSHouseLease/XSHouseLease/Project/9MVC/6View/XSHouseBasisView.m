//
//  XSHouseBasisView.m
//  XSHouseLease
//
//  Created by xs on 2020/4/10.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseBasisView.h"

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


@implementation XSItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.myImageView = imageView;

        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.masksToBounds = YES;;
//        label.layer.cornerRadius = 5;
//        label.layer.borderWidth = 0.5;
        label.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
         [self.contentView addSubview:label];
         self.titleLable = label;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(0, 0, self.width, self.height - 10);
    self.titleLable.frame = CGRectMake(0, self.height - 18, self.width, 18);
}
- (void)setModel:(XSHouseModuleModel *)model{
    _model = model;
    if (model.iconName) {
        self.myImageView.image = [UIImage imageNamed:model.iconName];
    }else{
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    }
    self.titleLable.text = model.name;
}
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
