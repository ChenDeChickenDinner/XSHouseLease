//
//  XSImagesTableViewCell.m
//  XSHouseLease
//
//  Created by xs on 2020/4/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSImagesTableViewCell.h"

@interface XSCollectionViewImageCell:UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,copy) NSString *imageUrl;
@end
@implementation XSCollectionViewImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;

        [self.contentView addSubview:imageView];
    }
    return self;
}
- (void)layoutSubviews{
    self.imageView.frame = self.contentView.bounds;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}
@end


@interface XSImagesTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation XSImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(80, 45);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSCollectionViewImageCell class] forCellWithReuseIdentifier:@"XSCollectionViewImageCell"];
    
}
- (void)setDataModel:(XSHouseDetailsDataImgsModel *)dataModel{
    _dataModel = dataModel;
    self.title.text = dataModel.name;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModel.contentImg.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *iamgeStr = [self.dataModel.contentImg safeObjectAtIndex:indexPath.row];
    XSCollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XSCollectionViewImageCell" forIndexPath:indexPath];
    cell.imageUrl = iamgeStr;
    return cell;
}
@end
