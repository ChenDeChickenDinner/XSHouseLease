//
//  XSPageViewController.h
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN
@interface XSListContentViewController : XSBaseViewController<JXCategoryListContentViewDelegate>

@end
@interface XSPageViewController : XSBaseViewController
- ( NSArray<NSString *>*)getTitlese;
- (NSArray<id<JXCategoryListContentViewDelegate>>*)getListVc;
@end




NS_ASSUME_NONNULL_END
