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

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(HJAccount *))success failure:(void (^)(NSError *))failure
{
    HJAccountParam *param = [[HJAccountParam alloc]init];
    param.client_id = HJAppKey;
    param.client_secret = HJAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = HJRedirectUrl;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = HJAppKey;
    params[@"client_secret"] = HJAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = HJRedirectUrl;
    
    [HJHttpTool post:HJAccessTokenUrl parameters:params success:^(id responseObject) {
        HJAccount *account = [HJAccount accountWithDict:responseObject];
        if (success) {
            success(account);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
