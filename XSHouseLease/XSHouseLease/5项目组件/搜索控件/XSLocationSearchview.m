//
//  XSLocationSearchview.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSLocationSearchview.h"

@implementation XSLocationSearchview

+ (instancetype)locationSearchview{
    XSLocationSearchview *view  = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    return view;
}

@end
