//
//  XSHouseMasterInfoView.m
//  XSHouseLease
//
//  Created by xs on 2020/4/13.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseMasterInfoView.h"

@implementation XSHouseMasterInfoView
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _customView = [[NSBundle mainBundle] loadNibNamed:@"XSHouseMasterInfoView" owner:self options:nil].firstObject;
        [self addSubview:_customView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _customView.frame = self.bounds;
}
- (void)awakeFromNib{
    [super awakeFromNib];
      self.name.text = nil;
     self.callIm.layer.masksToBounds = YES;
     self.callIm.layer.cornerRadius = 5;
     self.cellPhone.layer.masksToBounds = YES;
     self.cellPhone.layer.cornerRadius = 5;
     self.cellPhone.layer.borderWidth = 1;
     self.cellPhone.layer.borderColor = [UIColor hb_colorWithHexString:@"#E82B2B" alpha:1].CGColor;
}
- (void)setModel:(XSHouseInfoShowModel *)model{
    _model = model;
    [self.image sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"userIcon"]];
    self.name.text = model.callName;
}

- (IBAction)callPhone:(id)sender {
    NSString *telString = [NSString stringWithFormat:@"telprompt://%@",self.model.callPhone];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString] options:@{} completionHandler:nil];
    }
    
}
- (IBAction)callMassage:(id)sender {
    [ProgressHUD showSuccess:@"努力开发中"];
}
@end
