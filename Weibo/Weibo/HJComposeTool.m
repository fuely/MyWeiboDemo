//
//  HJComposeTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/30.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposeTool.h"
#import "HJHttpTool.h"
#import "HJComposeParam.h"
#import "MJExtension.h"
#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJUploadParam.h"

@implementation HJComposeTool

+ (void)composeWithSatausText:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    HJComposeParam *param = [[HJComposeParam alloc] init];
    
    param.status = status;
    param.access_token = [HJAccountTool account].access_token;
    
    // 发送请求
    [HJHttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithImage:(UIImage *)image status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    HJComposeParam *param = [[HJComposeParam alloc] init];
    
    param.status = status;
    param.access_token = [HJAccountTool account].access_token;
    
    HJUploadParam *uploadParam = [[HJUploadParam alloc] init];
    uploadParam.fileName = @"image.png";
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.paramName = @"pic";
    uploadParam.mineType = @"image/png";
    
    // 发送请求
    [HJHttpTool upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadParam success:^{
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
