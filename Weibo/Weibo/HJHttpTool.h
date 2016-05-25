//
//  HJHttpTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJUploadParam;

@interface HJHttpTool : NSObject

+ (void)get:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

+ (void)upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(HJUploadParam *)uploadParam
       success:(void (^)())success
       failure:(void (^)(NSError *error))failure;

@end
