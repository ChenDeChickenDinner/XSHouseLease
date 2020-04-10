//
//  XSHouseSubCollectionviewACell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSCollectionViewCell.h"
#import "XSHouseSubTableViewCell.h"

static NSString *CollectionCellIdentifier = @"CollectionCellIdentifierA";

@interface XSHouseSubCollectionviewACell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidth;

@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@end

@implementation XSHouseSubCollectionviewACell

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(77, 28);
        _layout.minimumInteritemSpacing = 12;
        _layout.minimumLineSpacing = 12;
    }
    return _layout;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;

    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellIdentifier];

}

- (void)refreshData{
    self.title.text = self.dataModel.title;
    XSKeyValueModel *dataModel = self.dataModel.arrayValue.firstObject;
    CGFloat itemSizeWidth = self.layout.itemSize.width;
    CGFloat Spacing = self.layout.minimumInteritemSpacing;
    self.collectionViewWidth.constant = (itemSizeWidth + Spacing) * dataModel.values.count;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:section];
    return dataModel.values.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    XSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifier forIndexPath:indexPath];
    cell.valueModel = valeModel;
    [cell refreshData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    NSLog(@"1111");
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    if (dataModel.multiple) {
        valeModel.isSelect = !valeModel.isSelect;
    }else{
         for (XSValue *valeModel  in dataModel.values) {
              valeModel.isSelect = NO;
          }
        valeModel.isSelect = YES;
    }
    [self.collectionView reloadData];
}
@end
