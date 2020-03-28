//
//  XSRoundedView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/17.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSRoundedView.h"

@implementation XSRoundedView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.masksToBounds = [self masksToBounds];;
    self.layer.cornerRadius = [self cornerRadius];
    self.layer.borderWidth = [self borderWidth];
    self.layer.borderColor = [self borderColor];

}
- (BOOL)masksToBounds{
    return YES;
}
- (CGFloat)cornerRadius{
    return 4.5;
}
- (CGFloat)borderWidth{
    return 0;
}
- (CGColorRef)borderColor{
    return [UIColor clearColor].CGColor;
}
@end

@implementation XSBorderView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 4.5;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = XSColor(232, 43, 43).CGColor;
}
@end


@implementation XSBorderLable
- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
//    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
//    self.layer.borderColor = XSColor(232, 43, 43).CGColor;
}
@end

@implementation XSRoundedBtnView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.masksToBounds = [self masksToBounds];;
    self.layer.cornerRadius = [self cornerRadius];
    self.layer.borderWidth = [self borderWidth];
    self.layer.borderColor = [self borderColor];
}
- (BOOL)masksToBounds{
    return YES;
}
- (CGFloat)cornerRadius{
    return 4.5;
}
- (CGFloat)borderWidth{
    return 0;
}
- (CGColorRef)borderColor{
    return [UIColor clearColor].CGColor;
}
@end

@implementation XSRoundedBtn1View
- (CGFloat)cornerRadius{
    return 20.0;
}
@end


