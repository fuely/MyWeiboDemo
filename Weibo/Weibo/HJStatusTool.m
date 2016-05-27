//
//  HJStatusTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJStatusTool.h"
#import "HJStatusCacheTool.h"

#import "HJStatus.h"
#import "HJStatusParam.h"
#import "HJStatusResult.h"
#import "HJStatusFrame.h"

#import "MJExtension.h"

#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJHttpTool.h"

#define HJStatusFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"status.plist"]

@implementation HJStatusTool

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型,拼接参数
    HJStatusParam *param = [[HJStatusParam alloc] init];
    param.access_token = [HJAccountTool account].access_token;
    param.since_id = ID;
    
    // 发送请求
    [HJHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        [HJStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        //字典转模型
        HJStatusResult *result = [HJStatusResult objectWithKeyValues:responseObject];
        
        //模型转字典
        NSDictionary *plist = result.keyValues;
        
        [plist writeToFile:HJStatusFile atomically:YES];
        
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (HJStatus *status in result.statuses) {
            HJStatusFrame *statusF = [[HJStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    HJStatusParam *param = [[HJStatusParam alloc] init];
    param.access_token = [HJAccountTool account].access_token;
    param.max_id = ID;
#warning  先从缓存中获取数据
    // 加载缓存数据
    NSArray *statuses =  [HJStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (HJStatus *status in statuses) {
            HJStatusFrame *statusF = [[HJStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        // 不需要在发送请求
        return;
    }
    
#warning  存储数据
    // 发送请求
    [HJHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 存储数据
        [HJStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        HJStatusResult *result = [HJStatusResult objectWithKeyValues:responseObject];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (HJStatus *status in result.statuses) {
            HJStatusFrame *statusF = [[HJStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

@end
