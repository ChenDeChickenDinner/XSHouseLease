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
- (void)loadImageWithURL:(NSString *)URLString imageUrl:(NSURL *)imageUrl param:(NSDictionary *)aParam progress:(HBRequestProgress)downloadProgress callback:(HBCompletionBlock)callback {
    [self.operationManger POST:URLString parameters:aParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data =  [NSData dataWithContentsOfURL:imageUrl];
        if (data == nil) {
            data =  [NSData dataWithContentsOfFile:imageUrl.absoluteString];
        }
        if (data == nil) {
            NSLog(@"error-");

        }
        NSString *mimeType = [self getMIMETypeWithCAPIAtFilePath:imageUrl.absoluteString];
             NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
        NSString *timestr = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@",timestr,@"png"];
        NSLog(@"fileName =%@,mimeType = %@",fileName,mimeType);
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
//       [formData appendPartWithFileURL:imageUrl  name:@"file" error:nil];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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


 -(NSString *)getMIMETypeWithCAPIAtFilePath:(NSString *)path
 {
     if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
         return nil;
     }

     CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
     CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
     CFRelease(UTI);
     if (!MIMEType) {
         return @"application/octet-stream";
     }
     return (__bridge NSString *)(MIMEType)
     ;
 }
 
- (void)loadImageWithURL:(NSString *)URLString image:(UIImage *)image param:(NSDictionary *)aParam progress:(HBRequestProgress)downloadProgress callback:(HBCompletionBlock)callback {
    NSLog(@"URLString = %@ ;aParam = %@",URLString,aParam);
 
    [self.operationManger POST:URLString parameters:aParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        
        
        [formData appendPartWithFormData:imageData name:@"file.png"];
        
        
     } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
              XSNetworkResponse *response =  [XSNetworkResponse mj_objectWithKeyValues:responseObject];
              if (callback) callback(response,nil);
          }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (callback) callback(nil,error);

     }];
    
     
    
}
//- (void)loadImageWithURL:(NSString *)URLString image:(UIImage *)image param:(NSDictionary *)aParam progress:(HBRequestProgress)downloadProgress callback:(HBCompletionBlock)callback {
//    NSLog(@"URLString = %@ ;aParam = %@",URLString,aParam);
//    if (image == nil) {
//        return;
//    }
//    [self.operationManger POST:URLString parameters:aParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImagePNGRepresentation(image);
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
//        NSString *timestr = [formatter stringFromDate:[NSDate date]];
//        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"image_%@.png",timestr] mimeType:@"image/png"];
//
////          NSString *path = [[NSBundle mainBundle]pathForResource:@"xaxaxax"ofType:@"png"];
////          NSURL *url=[NSURL  fileURLWithPath:path];
////           [formData appendPartWithFileURL:url  name:@"file" error:nil];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success-%@",responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//             XSNetworkResponse *response =  [XSNetworkResponse mj_objectWithKeyValues:responseObject];
//             if (callback) callback(response,nil);
//         }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error-%@",error);
//        if (callback) callback(nil,error);
//
//    }];
//
//}
@end

/*ASCII字符集

  





48～57:0-9
65～90:A-Z
97～122:a-z
 
 */
/*
 域名：
 IP:
 端口号：
 文件路径(文件表示)：
 */



/*
 是不是一个url（信息的正确表达-编码）
 url各部分的含义（信息的正确解析-编码）
 是不是一个有效的url（服务器）
 
 
 
 URL通常被写成如下形式：<方案>:<方案描述部分>
 方案：一个URL包含了它使用的方案名称（<方案>）
 方案描述：在方案其后紧跟一个冒号，然后是一个字符串，这部分的解释由所使用的方案来决定

 特殊方案
 一些已经存在的标准协议和正处于试验中的协议之间的映射关系的轮廓用BNF语法定义进行描述
 
 
 通用方案语法:
 虽然URL其他部分的语法因方案的不同而不同，
 但那些直接使用基于IP的协议来定位因特网上的主机的URL方案都使用了如下形式的通用语法来表示特定的方案数据：
 <scheme>:// <user>:<password>@  <host> :<port> /<path>  ;<params> ?<query>  #<frag>
1.不同的协议 其后面部分不同
 <user>:<password>@ :FTP协议需要这个  ;<params> :FTP协议需要这个
例如:FTP://chen:123@www.baidu.com:80/ui/3;type=3?name=chen&old=18#aaa

 
 
  2.url的表示以及编码解码（计算机怎么识别成功的）

 1.整体所有各个部分 只能使用ASCII字符集编码的八位字节序列:
 2.每个字符在显示上有下面2种方式
  a:(直接字符表示)ASCII中的可显示字符
  b:(通过%后加两个十六进制数字的形式)%E6%B7%B1%E5%9C
2.对不安全的字符进行编码，例如:"{", "}", "|", "\", "^","~","[", "]","`" 空格
3.保留字符：
 1.许多URL方案保留了一些字符并赋予特定的含义，它们出现在URL的特定部位并表示特定的含义
 2.";","/", "?", ":", "@", "=" 和 "&" 可能被某个方案所保留，
 3.SO这些保留字符，当出现在 不是用作保留目的地方必须进行编码
4.数字 字母  用作保留目的的保留字符 以及$-_.+!*'()这些特殊字符 可不进行编码
5.不必进行编码的字符（包括字母与数字）如果出现在URL的特定部位，只要它们不用作保留目的，则可进行编码
6.最终的解决方案 URL的编码 解码
 1.各种文字显示的-->编码-->传输
 2.传输过来的-->编码-->显示
 url encode？
 
 3.服务端与客户端 在编码解码上的约定与问题
 1.没有 或者 多次编码 解码 造成
 
 5.URL中各部分的含义 已经表达编码方式
 1.协议-schem:获取资源时使用的协议
  a.(公用协议)大家共识的URL协议， 这些已经被大多数系统收集采纳了 比如HTTP/tel/sms

  
  
  4.<user>:<password>:
  a.某些协议需要(用户名:密码)才可以获取资源;
  b.用户名（和密码）如果存在的话，其后紧跟一个商用符号“@”;
  c.在用户名和密码字段中出现的任何“:”，“@”或者“/”都要进行编码;
  d.注意空的用户名或者密码不同于没有用户名和密码；决不能在没有指定用户名的情况下指定密码
  

  
  Host:访问的域名或者IP地址
  0.哪一段算host:
  1.域名的表示规则:
  2.IP的表示规则:
  3.域名和IP的正确区分:
  
  Port:端口号
  1.大部分方案都给协议指定一个默认的端口。
  2.也可以随意指定一个十进制形式的端口，并用冒号与主机隔开。
  3.如果忽略端口，那么这个冒号也要忽略。
   http://www.baidu.com
   http://www.baidu.com:
   http://www.baidu.com:80
  
  
  Path:文件资源路径
  0.注意主机（或端口）与url－路径间的“/”不是url－路径的一部分
  1.路径的语法依赖于所使用的方案。也依赖于它在方案中的解释方法
  
  params:被某些协议用来指定输入参数，参数是 名/值对，一个URL可以包含多个参数对，用"；"和 其他的参数对分隔
  query:被某些协议用来指定输入参数，参数是 名/值对，一个URL可以包含多个参数对，用"；"和 其他的参数对分隔
  frag:资源的一部分的一个名称,不会被提交到服务器，使用"#"分隔：例如网页中的“书签”，用来跳转到一个网页的指定位置
 

 

 
 3.怎么才算一个url
 a.是一个url(能去解析的)
 1.在表示上首先 其中肯定不能有 url不能识别的字符 比如:空格 汉字等
 2.在纯语法层哪些是可以省略的
 3.在不同的环境下，是否能判断其是否是一个url需要看当前的系统处理
    2a:比如浏览器中 可以省略 协议 端口部分
    2b:在开发环境中 又不一样 （@"http:"）（@"http://"）（@"://"）在ios中都可以算作一个url
 
4.是否是一个有效的url
 
 
 
 
 HTTP URL 方案  http://<host>:<port>/<path>?<searchpart>
 
 */
