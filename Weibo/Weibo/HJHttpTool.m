//
//  HJHttpTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJHttpTool.h"
#import "HJUploadParam.h"

#import "AFNetworking.h"

@implementation HJHttpTool

+ (void)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //获取HTTP请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //发送请求
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 获取请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    // 发送请求
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

+ (void)upload:(NSString *)URLString parameters:(id)parameters uploadParam:(HJUploadParam *)uploadParam success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {//上传的文件全部在这拼接到formData
        
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.paramName fileName:uploadParam.fileName mimeType:uploadParam.mineType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
