//
//  XSBaseServer.h
//  XSHouseLease
//
//  Created by xs on 2020/4/9.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBaseViewController.h"



@interface XSBaseServer : NSObject
@property (nonatomic,strong) XSBaseViewController *requestVc;
- (NSMutableArray *)getDictWithJsonName:(NSString *)name;
@end


