//
//  XSHouseRentInfoCell.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseRentInfoCell.h"
#import "XSHouseRentInfoModel.h"


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

@property (weak, nonatomic) IBOutlet UIView *statusEditView;

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
    
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
        XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
        self.titleLable.text = newModel.title;
        [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg]];
        [self.image sd_setImageWithURL:[NSURL URLWithString:newModel.firstImg] placeholderImage:[UIImage imageNamed:@"houseDefImage"]];
        self.infoLable.text = [NSString stringWithFormat:@"%@/%@/%@",@"88m2",newModel.formType,newModel.orientationName];
        
        NSString *stra = [newModel.featurePoints safeObjectAtIndex:0];;
        NSString *strb = [newModel.featurePoints safeObjectAtIndex:1];;
        NSString *strc = [newModel.featurePoints safeObjectAtIndex:2];;

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
            self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
        }else{
            self.dealStatusLable.text = newModel.dealStatusName;
          self.dealStatusLable.textColor = [UIColor whiteColor];
          self.dealStatusLable.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
            
            
            self.statusEditViewHeight.constant = 0;
            [self.statusEditView removeFromSuperview];
        }
    }
}

NSString * XSHouseStatusTextColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    if (source == XSBHouseInfoSource_MyPublish) {
        NSString *color = @"";
        // 个人 // 1待审核 2审核失败 3已取消 4下架 5暂停 6发布
        if (status.integerValue == 1) {
            
        }else if (status.integerValue == 2){
            
        }else if (status.integerValue == 3){
            
        }else if (status.integerValue == 4){
            
        }else if (status.integerValue == 5){
            
        }else if (status.integerValue == 6){
            
        }else{
            
        }
    }else{
        // 公共 0未出租1是已出租
        if (dealStatus.integerValue == 0) {
           
        }else if (dealStatus.integerValue == 1){
           
        }else{
           
        }
    }
    return @"";
}
NSString * XSHouseStatusBkColor(NSNumber *status, NSNumber *dealStatus, XSBHouseInfoSource source) {
    
    return @"";
}
@end
