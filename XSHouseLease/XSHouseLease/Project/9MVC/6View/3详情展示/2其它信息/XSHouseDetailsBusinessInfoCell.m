//
//  XSHouseDetailsBusinessInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsBusinessInfoCell.h"
#import <objc/runtime.h>
#import "XSBusinessCollectionCell.h"
static NSString *XSHouseDetailsBusinessInfoCellStr = @"XSHouseDetailsBusinessInfoCellStr";

@interface XSHouseDetailsBusinessInfoCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSMutableArray<XSBusinessInfoModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end

@implementation XSHouseDetailsBusinessInfoCell

- (void)awakeFromNib{
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
     [self.collectionView registerClass:[XSBusinessCollectionCell class] forCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
//    self.collectionView.frame = self.bkView.bounds;
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
        XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
        XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        NSMutableDictionary *modeDict = [dataModel mj_keyValues];
        NSMutableArray *infoArray = [NSMutableArray array];
        for (XSBusinessInfoJsonModel *infoJsonModel in [XSConfigServer sharedInstance].businessInfoArray) {
            XSBusinessInfoModel *infoModel = [[XSBusinessInfoModel alloc]init];
            infoModel.name = infoJsonModel.keyName ;
            infoModel.value = [NSString stringWithFormat:@"%@",[modeDict safeObjectForKey:infoJsonModel.key]];
            [infoArray addObject:infoModel];
        }
        
        self.array = infoArray;
    }
    [self.collectionView reloadData];

}


// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XSBusinessInfoModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    
    // 创建cell (重用)
    XSBusinessCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}


// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSBusinessInfoModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if (dataModel.clickBlack) {
        dataModel.clickBlack(dataModel);
    }

    NSLog(@"选中cell: %ld", indexPath.row);
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        //设置cell的尺寸(宽度和高度)
        _layout.itemSize = CGSizeMake((KScreenWidth - 30)/2, 19);
        //设置竖直滚动放向(默认是竖直方向)
//        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置cell与cell之间的列距
        _layout.minimumInteritemSpacing = 0;
        //设置cell与cell之间的行距
        _layout.minimumLineSpacing = 8;
    }
    return _layout;
}


@end
