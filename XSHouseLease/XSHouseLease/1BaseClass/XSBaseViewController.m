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
    return policy;
}
- (AFHTTPSessionManager *)operationManager{
    if (_operationManager == nil) {
        _operationManager = [AFHTTPSessionManager manager];
//        _operationManager.operationQueue.maxConcurrentOperationCount = 3;
  
        //配置基地址 很关键 没这句啥都干不了

                NSString *cerPath = [[NSBundle mainBundle]pathForResource:@"fangdinghui" ofType:@"cer"];
                NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
                NSSet *cerSet = [NSSet setWithObjects:cerData, nil];
        // AFSSLPinningModeCertificate 使用证书验证模式
                AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
         // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
         // 如果是需要验证自建证书，需要设置为YES
                securityPolicy.allowInvalidCertificates = YES;
         //validatesDomainName 是否需要验证域名，默认为YES；
            //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
            //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
            //如置为NO，建议自己添加对应域名的校验逻辑。
                securityPolicy.validatesDomainName = NO;

                securityPolicy.pinnedCertificates = cerSet;



        _operationManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        [_operationManager setSecurityPolicy:[self customSecurityPolicy]];

        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
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
    NSString *token  = [XSUserServer sharedInstance].userModel.token;
      if (token) {
          [_operationManager.requestSerializer setValue:token forHTTPHeaderField:@"Authentication"];
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
}
@end
