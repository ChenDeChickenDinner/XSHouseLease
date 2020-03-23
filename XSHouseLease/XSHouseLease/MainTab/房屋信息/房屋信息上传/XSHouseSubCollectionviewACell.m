//
//  XSHouseSubCollectionviewACell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubCollectionviewACell.h"
@interface XSHouseSubCollectionviewACell ()
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
@end

@implementation XSHouseSubCollectionviewACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData{
    self.title.text = self.dataModel.title;

}
@end
