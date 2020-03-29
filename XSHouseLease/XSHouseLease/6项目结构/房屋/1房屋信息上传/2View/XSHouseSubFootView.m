//
//  XSHouseSubFootView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/29.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubFootView.h"

@implementation XSHouseSubFootView

+ (instancetype)houseSubFootView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}

@end
