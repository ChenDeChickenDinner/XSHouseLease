//
//  XSHouseSubTextViewCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubTextViewCell.h"
@interface XSHouseSubTextViewCell ()<UITextViewDelegate>
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
@implementation XSHouseSubTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.textColor = [UIColor hb_colorWithHexString:@"#4A4A4A" alpha:1];

    XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
     XSValue *valueData = model.values.firstObject;
    if (valueData.valueStr == nil) {
        textView.text = nil;
    }
    if (model.valuechangeStatus) {
        model.valuechangeStatus(model.key, XSBHouseKeyValueEditBegin);
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
     XSValue *valueData = model.values.firstObject;
     valueData.valueStr = textView.text.length > 0?textView.text:nil;
}
- (void)refreshData{
    if ([self.dataModel isKindOfClass:[XSKeyValue class]]) {
        XSKeyValue *keyValueModel = (XSKeyValue *)self.dataModel;
           self.title.text = keyValueModel.key;
            self.textView.text = keyValueModel.value;
          self.userInteractionEnabled = NO;
        self.textView.textColor = [UIColor hb_colorWithHexString:@"#4A4A4A" alpha:1];
    }else{
         self.title.text = self.dataModel.title;
        XSKeyValueModel *model = [self.dataModel.arrayValue safeObjectAtIndex:0];
         XSValue *valueData = model.values.firstObject;
        self.textView.text = valueData.valueStr?valueData.valueStr:valueData.placeholder;
        
        self.textView.textColor = [UIColor hb_colorWithHexString:valueData.valueStr?@"#4A4A4A":@"#E76D66" alpha:1];
//        self.textView.textColor = [UIColor hb_colorWithHexString:@"#4A4A4A" alpha:1];

        self.userInteractionEnabled = YES;

    }


}

@end
