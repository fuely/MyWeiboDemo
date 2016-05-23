//
//  HJOauthViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJOauthViewController.h"
#import "HJAccount.h"

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
    
    NSURL *url = [NSURL URLWithString:HJResquestTokeURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
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

}

@end
