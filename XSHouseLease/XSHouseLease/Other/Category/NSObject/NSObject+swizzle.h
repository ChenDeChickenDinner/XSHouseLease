//
//  NSObject+swizzle.h
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (swizzle)

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;
+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;
/**
 * 交换当前类实例方法
 */
+ (BOOL)swizzlingInstanceMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector;
/**
 * 交换某个类实例方法
 */
+ (BOOL)swizzlingInstance:(Class)clz orginalMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector;
/**
 * 交换某个类class方法
 */
+ (BOOL)swizzlingClass:(Class)klass replaceClassMethod:(SEL)methodSelector1 withMethod:(SEL)methodSelector2;
@end

