//
//  NSObject+safe.h
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (safe)

/**
 *  转换成nsstring－》nsnumber
 *
 *  @return NSnumber
 */
- (NSNumber *)toNumberIfNeeded;

@end


