//
//  XSRegionSearchView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSRegionSearchView.h"

@interface XSRegionSearchView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) UITextField *searchTextField;

@end
@implementation XSRegionSearchView

+(instancetype)searchView{
    XSRegionSearchView *view  = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
     return view;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor hb_colorWithHexString:@"#929292" alpha:1].CGColor;
    
//    self.layer.shadowOpacity = 1;// 阴影透明度
//
//    self.layer.shadowColor = [UIColor hb_colorWithHexString:@"#929292" alpha:1].CGColor;// 阴影的颜色
//
//    self.layer.shadowRadius = 3;// 阴影扩散的范围控制
//
//    self.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        self.searchBtn = searchBtn;
        
        UITextField *textField =  [[UITextField alloc]init];
        textField.placeholder = @"请输入小区或商圈名";
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
        textField.delegate = self;
        self.searchTextField = textField;
        [self addSubview:searchBtn];
        [self addSubview:textField];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.searchBtn.frame = CGRectMake(11, (self.height - 17)/2, 17, 17);
    self.searchTextField.frame = CGRectMake(CGRectGetMaxX(self.searchBtn.frame) + 10, 0, self.width - self.searchBtn.width - 10, 40);

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

@end
