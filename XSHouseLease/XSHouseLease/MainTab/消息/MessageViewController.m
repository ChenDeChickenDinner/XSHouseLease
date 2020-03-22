//
//  MessageViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "MessageViewController.h"
#import "YBModelFile.h"


@interface MessageViewController ()
@property(nonatomic,strong) NSThread *myThread;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    

 
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
        [YBMFConfig shareConfig].framework = YBMFFrameworkMJ;
        [YBMFConfig shareConfig].needCoding = NO;
        [YBMFConfig shareConfig].needCopying = NO;
        [YBMFConfig shareConfig].fileHHandler.ybmf_skipLine = YES;
        [YBMFConfig shareConfig].fileMHandler.ybmf_skipLine = YES;
        [YBMFConfig shareConfig].fileSuffix = @"";
//        [YBMFConfig shareConfig].ignoreType = YBMFIgnoreTypeAllDigital | YBMFIgnoreTypeMutable;
        [YBMFConfig shareConfig].baseClass = [XSBaseObject class];
//        [YBMFConfig shareConfig].filePartitionMode = YBMFFilePartitionModeTogether;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xsjson" ofType:@"json"];
      // 将文件数据化
      NSData *data = [[NSData alloc] initWithContentsOfFile:path];
      [YBModelFile createFileWithName:@"XSUserLogInModel" data:data];
    
}
@end

