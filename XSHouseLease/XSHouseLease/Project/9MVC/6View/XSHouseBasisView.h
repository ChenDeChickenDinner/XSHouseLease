//
//  XSHouseBasisView.h
//  XSHouseLease
//
//  Created by xs on 2020/4/10.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XSCollectionViewCell :  UICollectionViewCell
@property(nonatomic,strong) XSValue *valueModel;
@property (weak, nonatomic)  UILabel *textlabel;
- (void)refreshData;
@end

@interface XSItemCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseModuleModel  *model;
@property (weak, nonatomic)  UIImageView *myImageView;
@property (weak, nonatomic)  UILabel *titleLable;
@end

@interface XSBusinessCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSBusinessInfoModel  *model;
@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *contentLable;
@end
