//
//  XSVertiaciListView.m
//  XSHouseLease
//
//  Created by xs on 2020/4/17.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSVertiaciListView.h"

@implementation VerticalListCellModel

@end

@implementation VerticalListSectionModel

@end


@implementation VerticalListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];

        _itemImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.itemImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.itemImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.itemImageView.center = CGPointMake(self.bounds.size.width/2, 30);

    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemImageView.frame) + 5, self.bounds.size.width, 30);
}

@end
@implementation VerticalSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(16, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, 200, self.titleLabel.bounds.size.height);
}

@end
@implementation VerticalSectionCategoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    }
    return self;
}

@end
@implementation VerticalListCollectionView


- (void)layoutSubviews {
    [super layoutSubviews];

    self.layoutSubviewsCallback();
}


@end
