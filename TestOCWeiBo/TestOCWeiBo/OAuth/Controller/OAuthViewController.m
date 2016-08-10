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
#import "NetWorkManager.h"
@interface OAuthViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=3014923605&redirect_uri=https://www.baidu.com";
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
        NSString *str = [[tempStr componentsSeparatedByString:@"code="] lastObject];
        [self getLoginTockenWithCode:str];
    }
    
    
    return YES;
}


- (void)getLoginTockenWithCode:(NSString *)code
{
    NetWorkManager *manager = [NetWorkManager shareManager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3014923605";
    params[@"client_secret"] = @"0bf699ee2dedda651559ae65c5c9ff59";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://www.baidu.com";
    [manager postRequestWithUrl:@"oauth2/access_token" Dic:params Progress:^(NSProgress *progress) {
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        UserAccountInfo *account = [UserAccountInfo accountWithDict:responseObject];
        [UserAccountInfo saveAccount:account];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

@end
