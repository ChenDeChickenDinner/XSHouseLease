//
//  NSObject+category.h
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@class WelcomeController;

@interface NSObject (category)

void hb_swizzleMethod(Class hb_class, SEL originalSelector, SEL swizzledSelector);

@property (nonatomic, strong, readonly) NSMutableArray *associatedObjectNames;

/**
 *  为当前object动态增加分类
 *
 *  @param propertyName   分类名称
 *  @param value  分类值
 *  @param policy 分类内存管理类型
 */
- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy;
/**
 *  获取当前object某个动态增加的分类
 *
 *  @param propertyName 分类名称
 *
 *  @return 值
 */
- (id)objc_getAssociatedObject:(NSString *)propertyName;
/**
 *  删除动态增加的所有分类
 */
- (void)objc_removeAssociatedObjects;

/**
 *  获取当前window对象
 */
+ (UIWindow *) window;

/**
 根据十六进制字符串生成UIColor对象
 */
- (UIColor *)hb_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


+ (UIViewController *)getTopViewController;

@end
