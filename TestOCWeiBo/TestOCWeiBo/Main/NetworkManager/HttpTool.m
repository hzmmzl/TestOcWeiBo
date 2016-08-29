//
//  HttpTool.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/29.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "NetWorkManager.h"
@implementation HttpTool
+(HttpTool *)shareManager
{
    static HttpTool *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[HttpTool alloc] init];
        }
    });
    return manager;
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params Progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure
{
    // 1.创建请求管理对象
     AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


+(void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray Progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        /*
        UIImage *image =[UIImage imageNamed:@"minion_02"];
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"file" fileName:@"abc.png" mimeType:@"image/png"];
         */
        
        /*通过url
         NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/CertificateSigningRequest.certSigningRequest"];
         // 任意的二进制数据MIMEType application/octet-stream
         // [formData appendPartWithFileURL:url name:@"file" fileName:@"abc.cer" mimeType:@"application/octet-stream" error:nil];
         [formData appendPartWithFileURL:url name:@"file" error:nil];
         */
        
        for (IWFormData *obj in formDataArray) {
            [formData appendPartWithFileData:obj.data name:obj.name fileName:obj.filename mimeType:obj.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params Progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.发送请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
@end

/**
 *  用来封装文件数据的模型
 */
@implementation IWFormData

@end
