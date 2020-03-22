//
//  XSBaseViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#define BASEURL @"http://120.27.95.26:1112/api/v1.0/"
@interface XSBaseViewController ()
@end

@implementation XSBaseViewController

- (XSUserInfoInterface *)userInfoInterface{
    if (_userInfoInterface == nil) {
        _userInfoInterface = [XSUserInfoInterface interfaceWithOperationManager:self.operationManager];
    }
    return _userInfoInterface;
}
- (AFHTTPSessionManager *)operationManager{
    if (_operationManager == nil) {
        _operationManager = [AFHTTPSessionManager manager];
//        _operationManager.operationQueue.maxConcurrentOperationCount = 3;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                  @"text/html",
                                                                                  @"text/json",
                                                                                  @"text/plain",
                                                                                  @"text/javascript",
                                                                                  @"text/xml",
                                                                                  @"image/*"]];
        [_operationManager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
    }
    return _operationManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)refreshUIData{
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
