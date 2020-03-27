//
//  XSHouseSubTableViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTableViewCell.h"

@interface XSHouseSubTableViewCell()

@property(nonatomic,strong) UILabel *label;

@end

@implementation XSHouseSubTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;;

}
+ (instancetype)cellWithtableView:(UITableView *)tableView{
    return [[self alloc]initWithtableView:tableView];
}
- (instancetype)initWithtableView:(UITableView *)tableView{
    XSHouseSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (instancetype)initWithDataModel:(XSHouseInfoCellModel *)dataModel reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (dataModel.arrayValue.count > 1) {
        
    }else{
        XSKeyValueModel *keyValueModel = dataModel.arrayValue.firstObject;
        
        if (keyValueModel.keyInputType == XSValueInputType_collectionview){
            // 1.只有一个key-value编辑选项
        }else if (keyValueModel.keyInputType == XSValueInputType_textView){
            // 1.只有一个key-value编辑选项
        }else{
            // 1.只有一个key-value编辑选项
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
            self.label = label;
            [self.contentView addSubview:label];

            
    
        }
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = CGRectMake(15,20,[self.label mj_textWidth],20);

}
- (void)refreshData{
    
}
@end


@interface XSCollectionViewCell ()
@property (weak, nonatomic)  UILabel *textlabel;

@end
@implementation XSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;;
        label.layer.cornerRadius = 5;
        label.layer.borderWidth = 0.5;
        [self.contentView addSubview:label];
         self.textlabel = label;
    }
    return self;
}
- (void)layoutSubviews{
    self.textlabel.frame = self.bounds;

}
- (void)refreshData{
    self.textlabel.text = self.valueModel.valueStr;
    if (self.valueModel.isSelect) {
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#FFFFFF" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1].CGColor;

    }else{
        self.textlabel.textColor = [UIColor hb_colorWithHexString:@"#444444" alpha:1];
        self.textlabel.backgroundColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1];
        self.textlabel.layer.borderColor = [UIColor hb_colorWithHexString:@"#EFEFEF" alpha:1].CGColor;

    }

}


//// 返回cell的尺寸大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(77, 28);      // 让每个cell尺寸都不一样
//}
//// 返回cell之间行间隙
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 12;
//}
//// 返回cell之间列间隙
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 12;
//}
// 设置上左下右边界缩进
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//
//    return UIEdgeInsetsMake(20, 20, 20, 20);
//}
@end
