//
//  XSHouseBasisView.h
//  XSHouseLease
//
//  Created by xs on 2020/4/10.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *XSHouseDetailsBusinessInfoCellStr = @"XSHouseDetailsBusinessInfoCellStr";
static NSString *XSHouseDetailsFacilitiesInfoCellStr = @"XSHouseDetailsFacilitiesInfoCellStr";
static NSString *XSItemCollectionViewCellStr = @"XSItemCollectionViewCellStr";

#pragma mark - 条件导航
@interface XSItemCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseModuleModel  *model;
@property (weak, nonatomic)  UIImageView *myImageView;
@property (weak, nonatomic)  UILabel *titleLable;
@end



#pragma mark - 枚举多选
@interface XSCollectionViewCell :  UICollectionViewCell
@property(nonatomic,strong) XSValue *valueModel;
@property (weak, nonatomic)  UILabel *textlabel;
- (void)refreshData;
@end




#pragma mark - 房屋其它信息(详情)
@interface XSBusinessCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSBusinessInfoModel  *model;
@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *contentLable;
@end


#pragma mark - 配套设施(详情电视)
@interface XSFacilitiesCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseDetailsFacilitiesModel  *model;
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *contentLable;
@property (weak, nonatomic)  UIView *bkView;

@end

