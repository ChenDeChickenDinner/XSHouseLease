//
//  XSBaseServer.m
//  XSHouseLease
//
//  Created by xs on 2020/4/9.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseServer.h"

@implementation XSBaseServer

- (XSBaseViewController *)requestVc{
    if (!_requestVc) {
        _requestVc = [[XSBaseViewController alloc]init];
    }
    return _requestVc;
}
- (NSMutableArray *)getDictWithJsonName:(NSString *)name{
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    return [NSMutableArray arrayWithArray:dataArray];
}
@end
