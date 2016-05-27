//
//  HJUserTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJUserTool.h"

#import "HJUserParam.h"
#import "HJUserUnreadResult.h"
#import "HJUser.h"
#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJHttpTool.h"

#import "MJExtension.h"

@implementation HJUserTool

+ (void)userInfoDidsuccess:(void (^)(HJUser *))success failure:(void (^)(NSError *))failure
{
    
    // 拼接参数
    HJUserParam *param = [[HJUserParam alloc] init];
    param.access_token = [HJAccountTool account].access_token;
    param.uid = [HJAccountTool account].uid;
    
    [HJHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        HJUser *user = [HJUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)unreadCountDidsuccess:(void (^)(HJUserUnreadResult *))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    HJUserParam *param = [[HJUserParam alloc] init];
    param.access_token = [HJAccountTool account].access_token;
    param.uid = [HJAccountTool account].uid;
    
    [HJHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        HJUserUnreadResult *userUnread = [HJUserUnreadResult objectWithKeyValues:responseObject];
        if (success) {
            success(userUnread);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
