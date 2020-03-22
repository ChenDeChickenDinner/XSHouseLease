//
//  XSNetworkInterface.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSNetworkInterface.h"

@implementation XSNetworkResponse
- (NSString *)description{
     return [NSString stringWithFormat:@"<%@: %p, result: %@,message:%@,data:%@", NSStringFromClass([self class]), self,self.code ,self.message,self.data];
}
@end

@interface XSNetworkInterface()
@property (nonatomic, strong) AFHTTPSessionManager *operationManger;

@end

@implementation XSNetworkInterface

- (XSOperationParam *)paramModel{
    if (_paramModel == nil) {
        _paramModel = [[XSOperationParam alloc]init];
    }
    return _paramModel;
}
+ (id)interfaceWithOperationManager:(AFHTTPSessionManager *)aOperationManger{
    XSNetworkInterface *interface = [[self alloc] init];
    interface.operationManger = aOperationManger;
    return interface;
}

- (void)POST:(NSString *)URLString param:(NSDictionary *)aParam progress:(HBRequestProgress)downloadProgress callback:(HBCompletionBlock)callback {
    NSLog(@"URLString = %@ ;aParam = %@",URLString,aParam);

    [self.operationManger POST:URLString parameters:aParam progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success-%@",responseObject);

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            XSNetworkResponse *response =  [XSNetworkResponse mj_objectWithKeyValues:responseObject];
            if (callback) callback(response,nil);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);

        if (callback) callback(nil,error);
    }];
 
}

- (void)GET:(NSString *)URLString param:(NSDictionary *)aParam progress:(HBRequestProgress)downloadProgress callback:(HBCompletionBlock)callback {
    NSLog(@"URLString = %@;aParam = %@",URLString,aParam);
    [self.operationManger GET:URLString parameters:aParam progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success-%@",responseObject);

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             XSNetworkResponse *response =  [XSNetworkResponse mj_objectWithKeyValues:responseObject];
             if (callback) callback(response,nil);
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
        if (callback) callback(nil,error);

    }];
}

@end
