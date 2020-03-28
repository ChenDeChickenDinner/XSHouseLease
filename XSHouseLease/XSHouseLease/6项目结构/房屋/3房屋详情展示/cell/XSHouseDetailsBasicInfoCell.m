//
//  XSHouseDetailsBasicInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsBasicInfoCell.h"

@interface XSHouseDetailsBasicInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablea;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLableb;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablec;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLableaW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablebW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablecW;


@property (weak, nonatomic) IBOutlet UILabel *rentPricelabe;
@property (weak, nonatomic) IBOutlet UILabel *formTypelabe;
@property (weak, nonatomic) IBOutlet UILabel *rarealabe;


@end

@implementation XSHouseDetailsBasicInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLable.text = nil;
    
    self.rentPricelabe.text = nil;

    self.formTypelabe.text = nil;
    self.rarealabe.text = nil;
    
    self.featurePointsLablea.text = nil;
    self.featurePointsLableb.text = nil;
    self.featurePointsLablec.text = nil;



}

- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    
    
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
        XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
        XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        
        self.titleLable.text = [NSString stringWithFormat:@"%@ %@ %@",dataModel.rentWayName,dataModel.estate,dataModel.formType];
         
        self.rentPricelabe.text = [NSString stringWithFormat:@"%@元/每月",dataModel.rentPrice];

         self.formTypelabe.text = dataModel.formType;
        
         self.rarealabe.text = [NSString stringWithFormat:@"%@㎡",dataModel.area];
         
         NSString *stra = [dataModel.featurePoints safeObjectAtIndex:0];;
         NSString *strb = [dataModel.featurePoints safeObjectAtIndex:1];;
         NSString *strc = [dataModel.featurePoints safeObjectAtIndex:2];;

        self.featurePointsLablea.text = stra;
        self.featurePointsLableb.text = strb;
        self.featurePointsLablec.text = strc;
       self.featurePointsLableaW.constant = stra.length > 0?[self.featurePointsLablea mj_textWidth] + 5:0;
       self.featurePointsLablebW.constant = strb.length > 0?[self.featurePointsLableb mj_textWidth] + 5:0;
       self.featurePointsLablecW.constant = strc.length > 0?[self.featurePointsLablec mj_textWidth] + 5:0;
        
    }
 
}


@end
