//
//  NSArray+Category.h
//  HBStockDev
//
//  Created by Walker on 16/6/13.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)


/**
 array针对enumerateObjectsUsingBlock的扩展

 @param block 出入一个block，参数为当前array元素类型，返回想要的类型
 @return 一个新的array
 */
- (NSArray *)arrayFromObjectsCollectedWithBlock:(id(^)(id object))block;

@end

