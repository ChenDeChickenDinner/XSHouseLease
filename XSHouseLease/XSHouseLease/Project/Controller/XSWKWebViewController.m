//
//  XSWKWebViewController.m
//  XSHouseLease
//
//  Created by xs on 2020/4/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSWKWebViewController.h"
#import <WebKit/WKWebView.h>
@interface XSWKWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong) WKWebView *webView;


@end

@implementation XSWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
//     self.webView.UIDelegate = self;
//     self.webView.navigationDelegate = self;
//     self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    
}



@end
