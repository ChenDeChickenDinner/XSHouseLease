//
//  XSItemCollectionViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSItemCollectionViewCell.h"
@interface XSItemCollectionViewCell ()
@property (weak, nonatomic)  UIImageView *myImageView;
@property (weak, nonatomic)  UILabel *titleLable;

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
//        self.myImageView.yy_imageURL = [NSURL URLWithString:model.icon];
//        [self.myImageView setYy_highlightedImageURL:[NSURL URLWithString:model.icon]];
    }
    self.titleLable.text = model.name;
}
@end
