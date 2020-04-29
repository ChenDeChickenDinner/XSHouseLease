//
//  XSHouseModuleViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"

#pragma mark - 条件导航显示

@interface XSItemCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseModuleModel  *model;
@property (weak, nonatomic)  UIImageView *myImageView;
@property (weak, nonatomic)  UIImageView *tipImage;
@property (weak, nonatomic)  UILabel *titleLable;
@end

@interface XSHouseModuleViewController : XSBaseViewController
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@end


