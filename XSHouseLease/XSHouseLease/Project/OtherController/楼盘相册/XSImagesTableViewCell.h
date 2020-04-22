//
//  XSImagesTableViewCell.h
//  XSHouseLease
//
//  Created by xs on 2020/4/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface XSCollectionViewImageCell:UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,copy) NSString *imageUrl;
@end
@interface XSImagesTableViewCell : UITableViewCell
@property (nonatomic, strong) XSHouseDetailsDataImgsModel *dataModel;

@end

NS_ASSUME_NONNULL_END
