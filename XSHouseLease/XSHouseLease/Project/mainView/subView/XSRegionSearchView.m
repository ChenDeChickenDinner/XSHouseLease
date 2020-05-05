//
//  XSRegionSearchView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSRegionSearchView.h"
#import "KxMenu.h"
#import "XSHouseInfoTableView.h"

@interface XSRegionSearchView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *bkView;
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,assign) BOOL def;
@property(nonatomic,assign) XSBHouseType houseType;

@end
@implementation XSRegionSearchView
- (instancetype)initWithFrame:(CGRect)frame type:(XSBHouseType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.houseType = type;
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
        XSClickBtn *searchBtn = [XSClickBtn buttonWithType:UIButtonTypeCustom];

        if (self.houseType <= 0) {
            self.houseType = XSBHouseType_old;
            self.def = YES;
            [searchBtn setTitle:@"二手房" forState:UIControlStateNormal];
            searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [searchBtn setTitleColor:XSColor(74, 74, 74) forState:UIControlStateNormal];
            [searchBtn setImage:[UIImage imageNamed:@"x_arrow"] forState:UIControlStateNormal];
            [searchBtn addTarget:self action:@selector(KxMenuShowWithSender:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        }
         self.searchBtn = searchBtn;
        [bkView addSubview:searchBtn];
        
        UITextField *textField =  [[UITextField alloc]init];
        textField.placeholder = @"请输入小区";
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
        textField.delegate = self;
        self.searchTextField = textField;
        
        [self addSubview:bkView];

        [bkView addSubview:textField];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bkView.frame = self.bounds;
    if (self.def) {
        self.searchBtn.frame = CGRectMake(11, (self.height - 17)/2, 55, 17);
    }else{
        self.searchBtn.frame = CGRectMake(11, (self.height - 17)/2, 17, 17);
    }
    self.searchTextField.frame = CGRectMake(CGRectGetMaxX(self.searchBtn.frame) + 10, 0, self.width - self.searchBtn.width - 10, self.height);

}

-(void)KxMenuShowWithSender:(UIButton *)sender{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    CGRect senderFrame = sender.frame;
    senderFrame.origin.y -= 25;
    CGRect rect = [sender convertRect:senderFrame toView:window];
    KxMenuItem * realPriceItem = [KxMenuItem menuItem:@"二手房" image:nil target:self action:@selector(priceMenuItemClicked:)];
     realPriceItem.tag = 1;
     realPriceItem.foreColor = XSColor(47, 47, 47);
     KxMenuItem * costPriceItem = [KxMenuItem menuItem:@"新房" image:nil target:self action:@selector(priceMenuItemClicked:)];
    costPriceItem.tag = 2;
    costPriceItem.foreColor = XSColor(47, 47, 47);
    
    [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KxMenu showMenuInView:window fromRect:rect menuItems:@[realPriceItem,costPriceItem]];

}
-(void)priceMenuItemClicked:(KxMenuItem *)priceMenuItem{
    self.houseType = (XSBHouseType)priceMenuItem.tag;
    if (priceMenuItem.tag == 1) {
        [self.searchBtn setTitle:@"二手房" forState:UIControlStateNormal];
    }else{
        [self.searchBtn setTitle:@"新房" forState:UIControlStateNormal];
    }
}
-(void)beganEditing{
    [self.searchTextField becomeFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.searchBlack && !self.search) {
        self.searchBlack(textField.text,self.houseType);
     }
    return self.search;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (self.searchBlack) {
             self.searchBlack(textField.text,self.houseType);
         }
    }
 
}

@end
