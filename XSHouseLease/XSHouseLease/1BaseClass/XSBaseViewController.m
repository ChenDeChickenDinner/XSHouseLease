//
//  XSBaseViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#define BASEURL @"https://test.fangdinghui.cn/api/v1.0/"
@interface XSBaseViewController ()
@end

@implementation XSBaseViewController

- (XSUserInfoInterface *)userInfoInterface{
    if (_userInfoInterface == nil) {
        _userInfoInterface = [XSUserInfoInterface interfaceWithOperationManager:self.operationManager];
    }
    return _userInfoInterface;
}
- (XShouseSubNetworkInterface *)subInfoInterface{
    if (_subInfoInterface == nil) {
        _subInfoInterface = [XShouseSubNetworkInterface interfaceWithOperationManager:self.operationManager];
    }
    return _subInfoInterface;
}
- (AFSecurityPolicy *)customSecurityPolicy{
    /** https */
    NSString*cerPath = [[NSBundle mainBundle] pathForResource:@"fangdinghui"ofType:@"cer"];
    NSData*cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet*set = [[NSSet alloc] initWithObjects:cerData,nil];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    policy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    return policy;
}
- (AFHTTPSessionManager *)operationManager{
    if (_operationManager == nil) {
        _operationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://test.fangdinghui.cn"]];
//        _operationManager.operationQueue.maxConcurrentOperationCount = 3;
        [_operationManager setSecurityPolicy:[self customSecurityPolicy]];
        _operationManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                  @"text/html",
                                                                                  @"text/json",
                                                                                  @"text/plain",
                                                                                  @"text/javascript",
                                                                                  @"text/xml",
                                                                                  @"image/*"]];
        [_operationManager.requestSerializer setValue:@"application/json;charset=UTF-8;multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        [_operationManager.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];

    }
    NSString *token  = [XSUserServer sharedInstance].userModel.token;
      if (token) {
          [_operationManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
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

- (void)alertWithMessage:(NSString *)str{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * act =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];

        [self presentViewController:alert animated:YES completion:nil];
    
//    [ProgressHUD showSuccess:@"努力开发中"];
//    [ProgressHUD showSuccess:str];
}
@end
