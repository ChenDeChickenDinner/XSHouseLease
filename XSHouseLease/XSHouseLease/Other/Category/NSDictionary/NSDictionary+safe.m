//
//  NSDictionary+safe.m
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import "NSDictionary+safe.h"

@implementation NSDictionary (safe)

+ (id)safeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key
{
    if (object==nil || key==nil) {
        return [self dictionary];
    } else {
        return [self dictionaryWithObject:object forKey:key];
    }
}

@end
