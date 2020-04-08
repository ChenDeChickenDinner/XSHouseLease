//
//  XSHouseSubCollectionviewBCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//
static NSString *CollectionCellIdentifierB = @"CollectionCellIdentifierB";

#import "XSHouseSubCollectionviewBCell.h"
@interface XSHouseSubCollectionviewBCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *frontDescribe;
@property (weak, nonatomic) IBOutlet UILabel *hindDescribe;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (weak, nonatomic) IBOutlet UITextView *textView ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DescribeconstraintA;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DescribeconstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DescribeconstraintC;
@property (weak, nonatomic) IBOutlet UILabel *valueViewFirst;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end
@implementation XSHouseSubCollectionviewBCell


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        //设置cell的尺寸(宽度和高度)
        _layout.itemSize = CGSizeMake(77, 28);
        //设置竖直滚动放向(默认是竖直方向)
//        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置cell与cell之间的列距
        _layout.minimumInteritemSpacing = 12;
        //设置cell与cell之间的行距
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
    self.collectionView.pagingEnabled = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellIdentifierB];

}

- (void)refreshData{
    self.title.text = self.dataModel.title;
//    XSKeyValueModel *dataModel = self.dataModel.arrayValue.firstObject;
    [self.collectionView reloadData];
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:section];
    return dataModel.values.count;
}
// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XSKeyValueModel *dataModel = [self.dataModel.arrayValue safeObjectAtIndex:indexPath.section];
    XSValue *valeModel = [dataModel.values safeObjectAtIndex:indexPath.row];
    
    // 创建cell (重用)
    XSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifierB forIndexPath:indexPath];
    cell.valueModel = valeModel;
    [cell refreshData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
}
// 选中某个cell
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

    NSLog(@"选中cell: %ld", indexPath.row);
    [self.collectionView reloadData];

}
- (void)setHighlighted:(BOOL)highlighted{
    self.backgroundView.backgroundColor = nil;
}
//-  (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    return NO;
//}
@end
