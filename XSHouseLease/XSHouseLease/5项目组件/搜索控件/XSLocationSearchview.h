//
//  XSLocationSearchview.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSLocationSearchview : UIView


@property(nonatomic,copy) searchBlack searchBlack;
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (strong, nonatomic) NSMutableArray<XSHousehots *> *hotsSearchArray;
+ (instancetype)locationSearchview;
@end

NS_ASSUME_NONNULL_END
