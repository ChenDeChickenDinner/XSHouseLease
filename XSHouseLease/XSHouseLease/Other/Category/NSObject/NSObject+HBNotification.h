//
//  NSObject+HBNotification.h
//  HBUserFeedback
//
//  Created by 张二帅 on 16/5/15.
//  Copyright © 2016年 Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HBNotification)


/**
 *  处理处理通知  需重写实现
 *
 *  @param notification
 */
- (void)handleNotification:(NSNotification *)notification;
/**
 *  注册通知
 *
 *  @param name 通知名称
 */
- (void)observeNotification:(NSString *)name;
/**
 *  取消注册通知
 *
 *  @param name 通知名称
 */
- (void)unobserveNotification:(NSString *)name;
/**
 *  取消注册的所有通知
 */
- (void)unobserveAllNotifications;
/**
 *  发送通知
 *
 *  @param name 通知名称
 *
 *  @return
 */
- (void)postNotification:(NSString *)name;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object (notificationSender)
 *
 *  @return
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object notificationSender
 *  @param info 传递的参数
 *
 *  @return
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object userInfo:(NSDictionary *)info;

@end
