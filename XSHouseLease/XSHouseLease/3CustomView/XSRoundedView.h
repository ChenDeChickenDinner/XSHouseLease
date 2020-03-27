//
//  XSRoundedView.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/17.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSRoundedView : UIView
- (void)borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;
@end

@interface XSRoundedBtnView : UIButton

@end

@interface XSRoundedBtn1View : XSRoundedBtnView

@end

@interface XSBorderView : UIView

@end

NS_ASSUME_NONNULL_END
