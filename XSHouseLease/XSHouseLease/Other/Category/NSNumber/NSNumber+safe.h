//
//  NSNumber+safe.h
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (safe)

- (BOOL)safeIsEqualToNumber:(NSNumber *)number;

- (NSComparisonResult)safeCompare:(NSNumber *)otherNumber;

@end
