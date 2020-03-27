//
//  NSArray+Category.m
//  HBStockDev
//
//  Created by Walker on 16/6/13.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import "NSArray+Category.h"
#import "NSMutableArray+safe.h"

@implementation NSArray (Category)

- (NSArray *)arrayFromObjectsCollectedWithBlock:(id(^)(id object))block {
    
    __block NSMutableArray *collection = [NSMutableArray arrayWithCapacity:[self count]];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [collection safeAddObject:block(obj)];
    }];
    
    return collection;
}

@end

