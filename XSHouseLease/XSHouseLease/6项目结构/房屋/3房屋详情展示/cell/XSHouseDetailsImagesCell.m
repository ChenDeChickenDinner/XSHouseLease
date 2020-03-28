//
//  XSHouseDetailsImagesCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsImagesCell.h"

@interface XSHouseDetailsImagesCell ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property(nonatomic,strong) UILabel *lable;

@end

@implementation XSHouseDetailsImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
    lable.text = @"图片";
    lable.font = [UIFont systemFontOfSize:11];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.layer.masksToBounds = YES;
    lable.layer.cornerRadius = 8;

    self.lable = lable;
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = nil;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;

    
    self.cycleScrollView = cycleScrollView;
    
    [self.bkView addSubview:cycleScrollView];
    [self.bkView addSubview:lable];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cycleScrollView.frame = self.bkView.bounds;
    self.lable.width = 50;
    self.lable.height = 18;
    self.lable.y = self.bkView.height - 28;
    self.lable.centerX = self.bkView.centerX;
    
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
        XSHouseDetailsInfoCellModel *newModel = (XSHouseDetailsInfoCellModel *)model;
        NSArray *urlarray = @[@"http:\/\/120.27.95.26\/system\/hire-house\/air.png",@"http:\/\/120.27.95.26\/system\/hire-house\/air.png",@"http:\/\/120.27.95.26\/system\/hire-house\/air.png"];
//        self.cycleScrollView.imageURLStringsGroup = newModel.dataModel.contentImg;
        self.cycleScrollView.imageURLStringsGroup = urlarray;

    }
}

@end
