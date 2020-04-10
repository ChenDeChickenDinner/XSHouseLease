//
//  XSHouseRentInfoCell.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseInfoShowModel.h"

#import "XSHouseRentStatusView.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseInfoShowModel.h"
#import "XSHouseDetailsController.h"
#import "XSMyPublishHosueController.h"
#import "XSHouseIntroduceController.h"
#import "XSMapViewController.h"
#import "XSPublicServer.h"
#import "XSConfigServer.h"




@interface XSHouseInfoCell : UITableViewCell
@property(nonatomic,strong)XSHouseInfoShowModel *model;
- (void)updateWithModel:(XSHouseInfoShowModel *)model;
@end


@interface XSHouseRentInfoCell : XSHouseInfoCell
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
@end





@interface XSHouseDetailsImagesCell : XSHouseInfoCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property(nonatomic,strong) UILabel *lable;
@end


@interface XSHouseDetailsBasicInfoCell : XSHouseInfoCell
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

@interface XSHouseDetailsBusinessInfoCell : XSHouseInfoCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSMutableArray<XSBusinessInfoModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@end


@interface XSHouseDetailsAddressInfoCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UIView *mapBkView;
@property (strong, nonatomic) XSMapViewController *mapVc;
@end


@interface XSHouseDetailsFacilitiesInfoCell : XSHouseInfoCell
@property (strong, nonatomic) XSHouseDetailsFacilitiesModel  *model;
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *contentLable;
@property (weak, nonatomic)  UIView *bkView;
@end


@interface XSHouseDetailsIntroduceInfoCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) UIView  *line;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (strong, nonatomic)  UIButton *selbtn;
@end


@interface XSHouseRecommendedCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listHeight;
@property (nonatomic,strong) XSHouseInfoTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (strong, nonatomic)  XSMyPublishHosueController *listvc;
@end

@interface XSFacilitiesCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseDetailsFacilitiesModel  *model;
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *contentLable;
@property (weak, nonatomic)  UIView *bkView;

@end
