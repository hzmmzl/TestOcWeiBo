//
//  NetWorkManager.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/10.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^progressBlock)(NSProgress *progress);
typedef void (^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^failureBlock)(NSURLSessionDataTask *task, NSError *error);
#define kHostName @"https://api.weibo.com/2/"
#define kHostOAuthName @"https://api.weibo.com/oauth2/"
@interface NetWorkManager : NSObject
+ (NetWorkManager *)shareManager;
- (void)getRequestWithUrl:(NSString *)url Parameters:(NSDictionary *)parameters Progress:(progressBlock)progress Success:(successBlock)successBlock Failure:(failureBlock)failBlock;
- (void)postRequestWithUrl:(NSString *)url Dic:(NSDictionary *)dic Progress:(progressBlock)progress Success:(successBlock)successBlock Failure:(failureBlock)failBlock;
@end
