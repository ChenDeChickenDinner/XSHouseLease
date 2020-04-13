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




#pragma mark -基类
@interface XSHouseInfoCell : UITableViewCell
@property(nonatomic,strong)XSHouseInfoShowModel *model;
- (void)updateWithModel:(XSHouseInfoShowModel *)model;
+ (NSInteger)indexForClassName:(NSString *)className;

@end

#pragma mark -租房列表
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
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *dealStatusLable;
@property (weak, nonatomic) IBOutlet UIView *watchNumBKView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusEditViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *watchNumLable;
@property (weak, nonatomic) IBOutlet XSHouseRentStatusView *statusEditView;
@end




#pragma mark -房屋图片
@interface XSHouseDetailsImagesCell : XSHouseInfoCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong) UILabel *lable;
@end

#pragma mark -基本信息A
@interface XSHouseDetailsBasicInfoCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablea;

@property (weak, nonatomic) IBOutlet UILabel *featurePointsLableb;
@property (weak, nonatomic) IBOutlet UILabel *featurePointsLablec;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLableaW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablebW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featurePointsLablecW;
@property (weak, nonatomic) IBOutlet UILabel *rentPricelabe;
@property (weak, nonatomic) IBOutlet UILabel *rentPricelabeBow;

@property (weak, nonatomic) IBOutlet UILabel *formTypelabe;
@property (weak, nonatomic) IBOutlet UILabel *rarealabe;
@end
#pragma mark -其它信息B
@interface XSHouseKeyVlaueCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseKeyVlaueModel  *model;
@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *contentLable;
@end
@interface XSHouseDetailsBusinessInfoCell : XSHouseInfoCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) NSArray<XSHouseKeyVlaueModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@end


#pragma mark -配套设施
@interface XSFacilitiesCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseFacilitiesModel  *model;
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *contentLable;
@property (weak, nonatomic)  UIView *bkView;
@end
@interface XSHouseDetailsFacilitiesInfoCell : XSHouseInfoCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) NSMutableArray<XSHouseFacilitiesModel *> *array;
@end

#pragma mark -地图信息
@interface XSHouseDetailsAddressInfoCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UIView *mapBkView;
@property (strong, nonatomic) XSMapViewController *mapVc;
@end


#pragma mark -房源介绍
@interface XSHouseDetailsIntroduceInfoCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) UIView  *line;
@property (strong, nonatomic)  UIButton *selbtn;
@end

#pragma mark -更多推荐
@interface XSHouseRecommendedCell : XSHouseInfoCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listHeight;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (nonatomic,strong) XSHouseInfoTableView *tableView;
@property (strong, nonatomic)XSMyPublishHosueController *listvc;
@end


