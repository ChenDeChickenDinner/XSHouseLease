//
//  XSLPDTViewController.h
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSLPDTViewController : XSPageViewController
@property (nonatomic, copy) NSArray<XSHouseDetailsDataDynamicsModel *> *dynamics;
@end

NS_ASSUME_NONNULL_END
