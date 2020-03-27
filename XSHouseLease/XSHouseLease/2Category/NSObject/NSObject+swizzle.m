//
//  NSObject+swizzle.m
//  HBStockFramework
//
//  Created by Walker on 16/5/5.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import "NSObject+swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (swizzle)

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    method_setImplementation(origMethod, class_getMethodImplementation(self, altSel));
    return YES;
}

+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c overrideMethod:origSel withMethod:altSel];
}

+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),class_getInstanceMethod(self, altSel));
    
    return YES;
}

+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c exchangeMethod:origSel withMethod:altSel];
}
//在进行方法swizzing时候，一定要注意类簇 ，比如 NSArray NSDictionary 等。
+ (BOOL)swizzlingInstanceMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector
{
    return [self swizzlingInstance:self orginalMethod:originalSelector replaceMethod:replaceSelector];
}
+(BOOL)swizzlingInstance:(Class)clz orginalMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector{
    
    Method original = class_getInstanceMethod(clz, originalSelector);
    Method replace = class_getInstanceMethod(clz, replaceSelector);
    BOOL didAddMethod =
    class_addMethod(clz,
                    originalSelector,
                    method_getImplementation(replace),
                    method_getTypeEncoding(replace));
    
    if (didAddMethod) {
        class_replaceMethod(clz,
                            replaceSelector,
                            method_getImplementation(original),
                            method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}

+ (BOOL)swizzlingClass:(Class)klass replaceClassMethod:(SEL)methodSelector1 withMethod:(SEL)methodSelector2
{
    if (!klass || !methodSelector1 || !methodSelector2) {
        NSLog(@"Nil Parameter(s) found when swizzling.");
        return NO;
    }
    
    Method method1 = class_getClassMethod(klass, methodSelector1);
    Method method2 = class_getClassMethod(klass, methodSelector2);
    if (method1 && method2) {
        IMP imp1 = method_getImplementation(method1);
        IMP imp2 = method_getImplementation(method2);
        
        Class classMeta = object_getClass(klass);
        if (class_addMethod(classMeta, methodSelector1, imp2, method_getTypeEncoding(method2))) {
            class_replaceMethod(classMeta, methodSelector2, imp1, method_getTypeEncoding(method1));
        } else {
            method_exchangeImplementations(method1, method2);
        }
        return YES;
    } else {
        NSLog(@"Swizzling Method(s) not found while swizzling class %@.", NSStringFromClass(klass));
        return NO;
    }
}
@end

