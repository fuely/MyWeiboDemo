//
//  HJAccountTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJAccountTool.h"
#import "HJAccount.h"
#import "HJAccountParam.h"
#import "HJHttpTool.h"
#import "MJExtension.h"

#define HJAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]

@implementation HJAccountTool

static HJAccount *_account;

+ (void)saveAccount:(HJAccount *)account
{
    //归档,要遵循NSCoding协议
    [NSKeyedArchiver archiveRootObject:account toFile:HJAccountFile];
}

//类方法
+ (HJAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:HJAccountFile];
        
        //判断是否过期,过期就返回nil
        if ([_account.expires_time compare:[NSDate date]] != NSOrderedDescending) {
            return nil;
        }
    }
    return _account;
}

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建用户模型
    HJAccountParam *param = [[HJAccountParam alloc]init];
    param.client_id = HJAppKey;
    param.client_secret = HJAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = HJRedirectUrl;
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"client_id"] = HJAppKey;
//    params[@"client_secret"] = HJAppSecret;
//    params[@"grant_type"] = @"authorization_code";
//    params[@"code"] = code;
//    params[@"redirect_uri"] = HJRedirectUrl;
    
    [HJHttpTool post:HJAccessTokenUrl parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        HJAccount *account = [HJAccount accountWithDict:responseObject];
        
        /*
         保存账号信息:
         数据存储一般会搞一个业务类,专门处理数据
         以后不想归档,用数据库,直接修改业务类
         */
        [HJAccountTool saveAccount:account];
        
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
