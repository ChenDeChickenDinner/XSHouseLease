//
//  NSMutableDictionary+safe.h
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(safe)

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;
- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;
- (id)safeObjectForKey:(id<NSCopying>)aKey;

@end
