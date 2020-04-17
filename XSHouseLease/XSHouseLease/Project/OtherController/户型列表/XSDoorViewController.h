//
//  XSDoorViewController.h
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSDoorViewController : XSPageViewController
@property (nonatomic, copy) NSArray<XSHouseDetailsDataFormsModel *> *forms;
@property (nonatomic, assign)BOOL simple;
- (void)loadData;
@end

NS_ASSUME_NONNULL_END
