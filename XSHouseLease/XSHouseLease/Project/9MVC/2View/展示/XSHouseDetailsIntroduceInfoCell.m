//
//  XSHouseDetailsIntroduceInfoCell.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsIntroduceInfoCell.h"
#import "XSHouseIntroduceController.h"

@interface XSHouseDetailsIntroduceInfoCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) UIView  *line;
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (strong, nonatomic)  UIButton *selbtn;

@end

@implementation XSHouseDetailsIntroduceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1];
    self.line  = view;
    [self.bkView addSubview:view];
    self.btn1.selected = YES;
    self.selbtn = self.btn1;

    [self.btn1 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn1 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];

    [self.btn2 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];
    [self.btn3 setTitleColor:XSColor(26, 26, 26) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:XSColor(232, 43, 43) forState:UIControlStateSelected];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self lineFrame];
    [self showText];
}
- (IBAction)click:(UIButton *)sender {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    sender.selected = YES;
    self.selbtn = sender;
    [self lineFrame];
    [self showText];

}
- (void)showText{
    if ([self.model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)self.model;
          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
          if (self.selbtn == self.btn1) {
              self.textView.text = dataModel.modelIntroduced;
              
          }else if (self.selbtn == self.btn2){
              self.textView.text = dataModel.estateIntroduced;

          }else if (self.selbtn == self.btn3){
              self.textView.text = dataModel.transportation;

          }else{
              self.textView.text = nil;

          }
    }else{
        self.textView.text = nil;

    }
    

}
- (void)lineFrame{
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(self.selbtn.x, self.bkView.height - 1, self.selbtn.width, 1);
    }];

}
- (IBAction)houseSource:(id)sender {
    XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)self.model;
      XSHouseRentInfoModel *dataModel = cellModel.dataModel;
    
    XSKeyValue *model1 = [[XSKeyValue alloc]init];
    model1.key = @"核心卖点";
    model1.value = dataModel.modelIntroduced;
    model1.cellClass = @"XSHouseSubTextViewCell";
    model1.cellHeight = [NSNumber numberWithInt:90];
    XSKeyValue *model2 = [[XSKeyValue alloc]init];
    model2.key = @"交通出行";
    model2.value = dataModel.transportation;
    model2.cellClass = @"XSHouseSubTextViewCell";
    model2.cellHeight = [NSNumber numberWithInt:90];
    
    XSKeyValue *model3 = [[XSKeyValue alloc]init];
    model3.key = @"小区介绍";
    model3.value = dataModel.estateIntroduced;
    model3.cellClass = @"XSHouseSubTextViewCell";
    model3.cellHeight = [NSNumber numberWithInt:90];

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];

    XSHouseIntroduceController *vc = [[XSHouseIntroduceController alloc]init];
    vc.array = array;
    
    UIViewController *nav = [NSObject getTopViewController];
    [nav.navigationController pushViewController:vc animated:YES];
}
- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
//    if ([model isKindOfClass:[XSHouseDetailsInfoCellModel class]]) {
//          XSHouseDetailsInfoCellModel *cellModel = (XSHouseDetailsInfoCellModel *)model;
//          XSHouseRentInfoModel *dataModel = cellModel.dataModel;
//
//      }
    [self showText];
}

@end
