//
//  HJOauthViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJOauthViewController.h"
#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJGuideTool.h"

#import "MBProgressHUD+MJ.h"

@interface HJOauthViewController ()<UIWebViewDelegate>

@end

@implementation HJOauthViewController

- (void)loadView{
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    
    //创建&加载请求
    /**
     问题:用AFNetworking 请求自签名的SSL ，出现错误：NSURLConnection/CFURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9843)  ,是自签名的HTTPs请求的API，不是加载的UIWebview 
     解决:在Info.plist中添加NSAppTransportSecurity类型Dictionary。
         在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES之后，把请求的URL都可以变成http而不是https了，如果还是https就报这个错。
     */
    NSURL *url = [NSURL URLWithString:HJResquestTokeURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    // 获取requestToken
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length > 0) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取accessToken
    [HJAccountTool accessTokenWithCode:code success:^(HJAccount *account) {
        // 保存账号
        [HJAccountTool saveAccount:account];
        // 选择跟控制器
        [HJGuideTool guideRootViewController:HJKeyWindow];
        
    } failure:^(NSError *error) {
        
    }];

    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在登录ing....."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
