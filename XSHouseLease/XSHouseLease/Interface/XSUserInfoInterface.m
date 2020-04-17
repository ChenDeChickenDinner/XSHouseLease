//
//  XSUserInfoInterface.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSUserInfoInterface.h"
#import "XSUserLogInModel.h"

@implementation XSUserInfoInterface
- (void)sendpictureWithPhone:(NSString *)phone  callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/picture",XSBaseUrl];
    if (phone) {
        url = [url stringByAppendingFormat:@"/%@",phone];
    }
    [self GET:url param:dict progress:nil callback:callback];

}

- (void)sendmessageWithPhone:(NSString *)phone pictureCode:(NSString *)pictureCode callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict safeSetObject:pictureCode forKey:@"pictureCode"];
    NSString *url = [NSString stringWithFormat:@"%@/message/sendmessage",XSBaseUrl];
    if (phone) {
        url = [url stringByAppendingFormat:@"/%@",phone];
    }
    [self GET:url param:dict progress:nil callback:callback];

}
- (void)loginWithCheckInfo:(XSUserLogInModel *)info callback:(HBCompletionBlock)callback{
    NSDictionary *param = [info mj_keyValues];
    NSString *url = [NSString stringWithFormat:@"%@/login",XSBaseUrl];
    [self POST:url param:param progress:nil callback:callback];
    
}

- (void)uploadImage:(NSString *)image callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/login",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
}
- (void)uploadImageUrl:(NSString *)imageUrl callback:(HBCompletionBlock)callback{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"%@/login",XSBaseUrl];
    [self POST:url param:dict progress:nil callback:callback];
}
@end
