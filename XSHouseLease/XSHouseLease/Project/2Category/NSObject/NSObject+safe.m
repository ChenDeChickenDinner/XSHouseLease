//
//  NSObject+safe.m
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import "NSObject+safe.h"

#import "NSObject+swizzle.h"

@implementation NSObject (safe)

- (NSNumber *)toNumberIfNeeded
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterNoStyle;
        NSNumber *myNumber = [f numberFromString:(NSString *)self];
        return myNumber;
    }
    
    return nil;
}

@end

