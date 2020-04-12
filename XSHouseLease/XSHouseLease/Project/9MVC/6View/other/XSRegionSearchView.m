//
//  XSRegionSearchView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSRegionSearchView.h"

@interface XSRegionSearchView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *bkView;
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) UITextField *searchTextField;

@end
@implementation XSRegionSearchView

+(instancetype)searchView{
    XSRegionSearchView *view  = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
     return view;
    
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
         self.layer.shadowColor = [UIColor hb_colorWithHexString:@"#929292" alpha:1].CGColor;
         self.layer.shadowOffset = CGSizeMake(0, 0);
         self.layer.shadowOpacity = 0.8;
         self.layer.shadowRadius = 9.0;
         self.layer.cornerRadius = 9.0;
        
        
        UIView *bkView = [[UIView alloc]initWithFrame:CGRectZero];
        bkView.backgroundColor = [UIColor whiteColor];
        bkView.layer.cornerRadius = 8;
//        bkView.layer.borderWidth = 0.5;
        bkView.layer.masksToBounds = YES;
        bkView.layer.borderColor = [UIColor hb_colorWithHexString:@"#929292" alpha:1].CGColor;

        self.bkView = bkView;
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        self.searchBtn = searchBtn;
        
        UITextField *textField =  [[UITextField alloc]init];
        textField.placeholder = @"请输入小区";
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
        textField.delegate = self;
        self.searchTextField = textField;
        
        [self addSubview:bkView];

        [bkView addSubview:searchBtn];
        [bkView addSubview:textField];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bkView.frame = self.bounds;
    self.searchBtn.frame = CGRectMake(11, (self.height - 17)/2, 17, 17);
    self.searchTextField.frame = CGRectMake(CGRectGetMaxX(self.searchBtn.frame) + 10, 0, self.width - self.searchBtn.width - 10, self.height);

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (self.searchBlack) {
             self.searchBlack(textField.text);
         }
    }
 
}

@end
