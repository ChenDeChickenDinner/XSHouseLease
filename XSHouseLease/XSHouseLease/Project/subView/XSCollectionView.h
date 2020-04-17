//
//  XSCollectionView.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSCollectionView : UIView
@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
