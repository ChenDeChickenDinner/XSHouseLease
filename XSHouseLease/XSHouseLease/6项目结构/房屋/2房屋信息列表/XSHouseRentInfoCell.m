//
//  XSHouseRentInfoCell.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseRentInfoCell.h"
#import "XSHouseRentInfoModel.h"

#import "XSHouseRentStatusView.h"

@interface XSHouseRentInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablea;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLableb;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablec;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLableaW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablebW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablecW;

@property (weak, nonatomic) IBOutlet UILabel *rentPricelabe;


@property (weak, nonatomic) IBOutlet UILabel *dealStatusLable;


@property (weak, nonatomic) IBOutlet UIView *watchNumBKView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusEditViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *watchNumLable;

@property (weak, nonatomic) IBOutlet XSHouseRentStatusView *statusEditView;
//@property (strong, nonatomic)  XSHouseRentStatusView *statusView ;

@end

@implementation XSHouseRentInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dealStatusLable.layer.masksToBounds = YES;
    self.dealStatusLable.layer.cornerRadius = 2;

    self.titleLable.text = nil;
    
    self.infoLable.text = nil;
    
    self.featurePointsLablea.text = nil;
    self.featurePointsLableb.text = nil;
    self.featurePointsLablec.text = nil;
//    self.featurePointsLablea.hidden = YES;
//    self.featurePointsLableb.hidden = YES;
//    self.featurePointsLablec.hidden = YES;

    self.featurePointsLableaW.constant = 0;
    self.featurePointsLablebW.constant = 0;
    self.featurePointsLablecW.constant = 0;
    
    
    self.dealStatusLable.text = nil;
    self.rentPricelabe.text = nil;

    self.watchNumLable.text = nil;
    
    self.watchNumBKView.hidden = YES;
    
    XSHouseRentStatusView *statusView = [[XSHouseRentStatusView alloc]init];
    self.statusEditView.clickEditStatus = ^(NSNumber * _Nonnull status) {
        NSLog(@"1111111111111--------%@",status);
    };
//    self.statusView = statusView;
    [self.statusEditView addSubview:statusView];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.statusView.frame = self.statusEditView.bounds;
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
        XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
        self.titleLable.text = newModel.title;
        [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg]];
        [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg] placeholderImage:[UIImage imageNamed:@"houseDefImage"]];
        self.infoLable.text = [NSString stringWithFormat:@"%@/%@/%@",@"88m2",newModel.formType,newModel.orientationName];
        
        NSString *stra = [newModel.featurePointNames safeObjectAtIndex:0];;
        NSString *strb = [newModel.featurePointNames safeObjectAtIndex:1];;
        NSString *strc = [newModel.featurePointNames safeObjectAtIndex:2];;

        self.featurePointsLablea.text = stra;
        self.featurePointsLableb.text = strb;
        self.featurePointsLablec.text = strc;
        self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
        self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
        self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;
 
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",newModel.rentPrice];

        self.watchNumLable.text = [NSString stringWithFormat:@"%@人已关注",newModel.watchNum];
        self.watchNumBKView.hidden = newModel.watchNum.intValue > 0?NO:YES;
        
        if (newModel.source == XSBHouseInfoSource_MyPublish) {
            self.statusEditViewHeight.constant = 23.0;
            self.dealStatusLable.text = newModel.statusName;
            self.dealStatusLable.textColor = [UIColor whiteColor];
           
            self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(newModel.status, newModel.dealStatus, newModel.source) alpha:1];
//            self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
        }else{
           
            
          self.dealStatusLable.text = newModel.dealStatusName;
          self.dealStatusLable.textColor = [UIColor whiteColor];
            self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:XSHouseStatusTextColor(newModel.status, newModel.dealStatus, newModel.source) alpha:1];
//          self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
            
            
            self.statusEditViewHeight.constant = 0;
            [self.statusEditView removeFromSuperview];
        }
        
        self.statusEditView.status = newModel.status;
    }
}

NSString * XSHouseStatusTextColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    NSString *color = @"";

    if (source == XSBHouseInfoSource_MyPublish) {
        // 个人 // 1待审核 2审核失败 3已取消 4下架 5暂停 6发布
        if (status.integerValue == XSBHouseSubStatus_DSH) {
            color = @"#E42629"; // 红色
        }else if (status.integerValue == XSBHouseSubStatus_SHSB){
            color = @"#E42629"; // 色
        }else if (status.integerValue == XSBHouseSubStatus_QXFB){
            color = @"#B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_XJ){
            color = @"B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_ZT){
            color = @"B7B7B9"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_FB){
            color = @"#30B936"; // 绿色
        }else{
            color = @"#E42629";// 红色
        }
    }else{
        // 公共 0未出租1是已出租
        if (dealStatus.integerValue == XSBHouseRentStatus_notrent) {
           color = @"#E42629";// 红色
        }else if (dealStatus.integerValue == XSBHouseRentStatus_rent){
           color = @"#FF642A";// 橙色
        }else{
           color = @"#FF642A";// 橙色
        }
    }
    return color;
}
NSString * XSHouseStatusBkColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    NSString *color = @"";

    if (source == XSBHouseInfoSource_MyPublish) {
        // 个人 // 1待审核 2审核失败 3已取消 4下架 5暂停 6发布
        if (status.integerValue == XSBHouseSubStatus_DSH) {
            color = @"待审核"; // 红色
        }else if (status.integerValue == XSBHouseSubStatus_SHSB){
            color = @"审核失败"; // 色
        }else if (status.integerValue == XSBHouseSubStatus_QXFB){
            color = @"已取消"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_XJ){
            color = @"下架"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_ZT){
            color = @"暂停"; // 灰色
        }else if (status.integerValue == XSBHouseSubStatus_FB){
            color = @"发布"; // 绿色
        }else{
            color = @"其他";// 红色
        }
    }else{
        // 公共 0未出租1是已出租
        if (dealStatus.integerValue == XSBHouseRentStatus_notrent) {
           color = @"未出租";//
        }else if (dealStatus.integerValue == XSBHouseRentStatus_rent){
           color = @"已出租";//
        }else{
           color = @"未出租";//
        }
    }
    return color;

}
@end
