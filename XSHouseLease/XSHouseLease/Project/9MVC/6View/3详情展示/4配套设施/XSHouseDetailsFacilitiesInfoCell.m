//
//  XSHouseDetailsFacilitiesInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsFacilitiesInfoCell.h"


@interface XSFacilitiesCollectionCell : UICollectionViewCell
@property (strong, nonatomic) XSHouseDetailsFacilitiesModel  *model;
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *contentLable;
@property (weak, nonatomic)  UIView *bkView;

@end

@implementation XSFacilitiesCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *bkView = [[UIView alloc]init];
        bkView.layer.masksToBounds = YES;
        bkView.layer.cornerRadius = 25;

        bkView.backgroundColor = [UIColor hb_colorWithHexString:@"#FF7A7A" alpha:1];
        [self.contentView addSubview:bkView];
        self.bkView = bkView;

        //添加自己需要个子视图控件
        self.contentView.backgroundColor = [UIColor clearColor];

        UIImageView *image = [[UIImageView alloc] init];
         [self.bkView addSubview:image];
         self.image = image;

        UILabel *contentLable = [[UILabel alloc] init];
         contentLable.backgroundColor = [UIColor clearColor];
         contentLable.font = [UIFont systemFontOfSize:12];
         contentLable.textAlignment = NSTextAlignmentCenter;

         contentLable.textColor = [UIColor hb_colorWithHexString:@"#BFBFBF" alpha:1];
          [self.contentView addSubview:contentLable];
          self.contentLable = contentLable;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bkView.frame = CGRectMake(0, 0, self.width, 50);;
    self.image.frame = self.bkView.bounds;
    self.contentLable.frame = CGRectMake(0, 50, self.width, self.height -50);
}
- (void)setModel:(XSHouseDetailsFacilitiesModel *)model{
    _model = model;
    self.bkView.backgroundColor = [UIColor hb_colorWithHexString:model.status?@"#FF7A7A":@"#FFCCCC" alpha:1];
    [self.image  sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.contentLable.text = model.name;
}
@end


@interface XSHouseDetailsFacilitiesInfoCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView ;
@property (strong, nonatomic) NSMutableArray<XSHouseDetailsFacilitiesModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end
static NSString *XSHouseDetailsFacilitiesInfoCellStr = @"XSHouseDetailsFacilitiesInfoCellStr";

@implementation XSHouseDetailsFacilitiesInfoCell

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
     [self.collectionView registerClass:[XSFacilitiesCollectionCell class] forCellWithReuseIdentifier:XSHouseDetailsFacilitiesInfoCellStr];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
}



- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
        XSHouseRentInfoModel *dataModel = cellModel.dataModel;
        
        NSMutableArray *allArray  =  [[XSHouseFixedData sharedInstance].facilitiesInfoArray mutableCopy];
        for (XSHouseDetailsFacilitiesModel *showModel in allArray) {
//            for (XSHouseDetailsFacilitiesModel *model in dataModel.facilities) {
//                if ([model.ID isEqualToNumber:showModel.ID]) {
//                    showModel.status = model.status;
//                }
//            }
            
            for (NSNumber *model in dataModel.facilities) {
                     if ([model isEqualToNumber:showModel.ID]) {
                         showModel.status = YES;
                     }
                 }
        }
         self.array = allArray;
        [self.collectionView reloadData];
      }
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XSHouseDetailsFacilitiesModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    
    // 创建cell (重用)
    XSFacilitiesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSHouseDetailsFacilitiesInfoCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}


// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSHouseDetailsFacilitiesModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];


    NSLog(@"选中cell: %ld", indexPath.row);
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc]init];
        //设置cell的尺寸(宽度和高度)
        _layout.itemSize = CGSizeMake(50, 85);
        //设置竖直滚动放向(默认是竖直方向)
//        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置cell与cell之间的列距
        _layout.minimumInteritemSpacing = 25 ;
        //设置cell与cell之间的行距
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

@end
