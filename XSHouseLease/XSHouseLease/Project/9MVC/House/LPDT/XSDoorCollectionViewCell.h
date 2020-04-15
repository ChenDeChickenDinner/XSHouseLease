//
//  XSDoorCollectionViewCell.h
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSDoorCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) XSHouseDetailsDataFormsModel *dataModel;
@property (weak, nonatomic) IBOutlet UIImageView *MyimageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *price;
@end

NS_ASSUME_NONNULL_END
