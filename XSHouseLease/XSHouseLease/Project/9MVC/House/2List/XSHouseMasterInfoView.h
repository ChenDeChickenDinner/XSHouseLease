//
//  XSHouseMasterInfoView.h
//  XSHouseLease
//
//  Created by xs on 2020/4/13.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSHouseMasterInfoView : UIView
@property (weak, nonatomic) IBOutlet UIView *houseUserInfoView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *cellPhone;
@property (weak, nonatomic) IBOutlet UIButton *callIm;
@property(nonatomic,strong)XSHouseInfoShowModel *model;
@property (nonatomic, strong) XSHouseMasterInfoView *customView;
@property (weak, nonatomic) IBOutlet UILabel *namedescribe;

@end


