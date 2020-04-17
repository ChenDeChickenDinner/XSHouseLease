//
//  XSVertiaciListView.h
//  XSHouseLease
//
//  Created by xs on 2020/4/17.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalListCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *itemName;

@end
@interface VerticalListSectionModel : NSObject

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, strong) NSArray <VerticalListCellModel *> *cellModels;

@end

@interface VerticalListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *itemImageView;

@end
@interface VerticalSectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

@end
@interface VerticalSectionCategoryHeaderView : UICollectionReusableView

@end

@interface VerticalListCollectionView : UICollectionView

@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

