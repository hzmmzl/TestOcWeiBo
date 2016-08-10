//
//  OAuthViewController.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/9.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "OAuthViewController.h"
#import "UserAccountInfo.h"
#import "NSString+Str.h"
#import "AFNetworking.h"
@interface OAuthViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=3014923605&redirect_uri=http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *tempStr = request.URL.absoluteString;
    NSRange range = [tempStr rangeOfString:@"code="];
    
    if (range.location != NSNotFound && range.length) {
       NSString *codeStr = [tempStr substringFromIndex:range.location];
        NSString *str = [[tempStr componentsSeparatedByString:@"code="] lastObject];
        [self getLoginTockenWithCode:str];
    }
    
    
    return YES;
}


- (void)getLoginTockenWithCode:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
}
@end
