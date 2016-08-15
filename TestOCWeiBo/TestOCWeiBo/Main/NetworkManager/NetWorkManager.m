//
//  NetWorkManager.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/10.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
@implementation NetWorkManager

+(NetWorkManager *)shareManager
{
    static NetWorkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[NetWorkManager alloc] init];
        }
    });
    return manager;
}

- (void)getRequestWithUrl:(NSString *)url Parameters:(NSDictionary *)parameters Progress:(progressBlock)progress Success:(successBlock)successBlock Failure:(failureBlock)failBlock
{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHostName,url];
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task,error);
    }];
}

- (void)postRequestWithUrl:(NSString *)url Dic:(NSDictionary *)dic Progress:(progressBlock)progress Success:(successBlock)successBlock Failure:(failureBlock)failBlock
{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@",kHostName,url] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task,error);
    }];
}
@end
