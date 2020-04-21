//
//  VerticalListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "XSImagesViewController.h"
#import "JXCategoryView.h"
#import "XSVertiaciListView.h"


static const CGFloat VerticalListCategoryViewHeight = 45;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 0;    //悬浮固定section的index

@interface XSImagesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray <NSString *> *headerTitles;
@property (nonatomic, strong) VerticalListCollectionView *collectionView;
@property (nonatomic, strong) JXCategoryTitleView *pinCategoryView;
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;
@property (nonatomic, strong) VerticalSectionCategoryHeaderView *sectionCategoryHeaderView;

@end

@implementation XSImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"楼盘相册";

    
    self.view.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[VerticalListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    __weak typeof(self)weakSelf = self;
    self.collectionView.layoutSubviewsCallback = ^{
        [weakSelf updateSectionHeaderAttributes];
    };
    

    [self.collectionView registerClass:[VerticalListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[VerticalSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[VerticalSectionCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"categoryHeader"];
    [self.view addSubview:self.collectionView];


    NSMutableArray *array = [NSMutableArray array];
     for (XSHouseDetailsDataImgsModel *dataModel  in self.dataSource) {
         NSString *str = [NSString stringWithFormat:@"%@(%ld)",dataModel.name,dataModel.contentImg.count];
         [array addObject:str];
     }
    self.headerTitles = array;



    self.pinCategoryView = [[JXCategoryTitleView alloc] init];
    self.pinCategoryView.backgroundColor = [UIColor whiteColor];
    self.pinCategoryView.frame = CGRectMake(0, 0, self.view.width, VerticalListCategoryViewHeight);
    self.pinCategoryView.titles = self.headerTitles;
    self.pinCategoryView.delegate = self;
    self.pinCategoryView.titleColor = [UIColor hx_colorWithHexStr:@"#929292"];
    self.pinCategoryView.titleSelectedColor = [UIColor hx_colorWithHexStr:@"#444444"];

//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    lineView.verticalMargin = 15;
//    self.pinCategoryView.indicators = @[lineView];
//
    
    [self.collectionView reloadData];

}

- (void)updateSectionHeaderAttributes {
    if (self.sectionHeaderAttributes == nil) {
        //获取到所有的sectionHeaderAtrributes，用于后续的点击，滚动到指定contentOffset.y使用
        NSMutableArray *attributes = [NSMutableArray array];
        UICollectionViewLayoutAttributes *lastHeaderAttri = nil;
        for (int i = 0; i < self.headerTitles.count; i++) {
            UICollectionViewLayoutAttributes *attri = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            if (attri) {
                [attributes addObject:attri];
            }
            if (i == self.headerTitles.count - 1) {
                lastHeaderAttri = attri;
            }
        }
        if (attributes.count == 0) {
            return;
        }
        self.sectionHeaderAttributes = attributes;

        //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
        
        XSHouseDetailsDataImgsModel *model = self.dataSource[self.headerTitles.count - 1];

        UICollectionViewLayoutAttributes *lastCellAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:model.contentImg.count - 1 inSection:self.headerTitles.count - 1]];
        CGFloat lastSectionHeight = CGRectGetMaxY(lastCellAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
        CGFloat value = (self.view.bounds.size.height - VerticalListCategoryViewHeight) - lastSectionHeight;
        if (value > 0) {
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.collectionView.frame = self.view.bounds;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    XSHouseDetailsDataImgsModel *model = self.dataSource[section];
    return model.contentImg.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VerticalListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XSHouseDetailsDataImgsModel *sectionModel = self.dataSource[indexPath.section];
    NSString *cellModel = sectionModel.contentImg[indexPath.row];
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:cellModel]];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == VerticalListPinSectionIndex) {
            VerticalSectionCategoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"categoryHeader" forIndexPath:indexPath];
            self.sectionCategoryHeaderView = headerView;
            if (self.pinCategoryView.superview == nil) {
                //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
                [headerView addSubview:self.pinCategoryView];
            }
            return headerView;
        }else {
            VerticalSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            XSHouseDetailsDataImgsModel *sectionModel = self.dataSource[indexPath.section];
            headerView.titleLabel.text = sectionModel.name;
            return headerView;
        }
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"other" forIndexPath:indexPath];
}







- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UICollectionViewLayoutAttributes *attri = self.sectionHeaderAttributes[VerticalListPinSectionIndex];
    if (scrollView.contentOffset.y >= attri.frame.origin.y) {
        //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
        if (self.pinCategoryView.superview != self.view) {
            [self.view addSubview:self.pinCategoryView];
        }
    }else if (self.pinCategoryView.superview != self.sectionCategoryHeaderView) {
        //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
        [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
    }

    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    //用户滚动的才处理
    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
    CGRect topRect = CGRectMake(0, scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1, self.view.bounds.size.width, 1);
    UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
    NSUInteger topSection = topAttributes.indexPath.section;
    if (topAttributes != nil && topSection >= VerticalListPinSectionIndex) {
        if (self.pinCategoryView.selectedIndex != topSection - VerticalListPinSectionIndex) {
            //不相同才切换
            [self.pinCategoryView selectItemAtIndex:topSection - VerticalListPinSectionIndex];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == VerticalListPinSectionIndex) {
        //categoryView所在的headerView要高一些
        return CGSizeMake(self.view.bounds.size.width, VerticalListCategoryViewHeight);
    }
    return CGSizeMake(self.view.bounds.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return (self.view.bounds.size.width - 100*3)/4;
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat margin = (self.view.bounds.size.width - 100*3)/4;
//    return UIEdgeInsetsMake(0, margin, 0, margin);
    return UIEdgeInsetsMake(0, 10, 0, 10);

}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //这里关心点击选中的回调！！！
    UICollectionViewLayoutAttributes *targetAttri = self.sectionHeaderAttributes[index + VerticalListPinSectionIndex];
    if (index == 0) {
        //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
        [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y) animated:YES];
    }else {
        //不是第一个，需要滚动到categoryView下面
        [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y - VerticalListCategoryViewHeight) animated:YES];
    }
}

@end
