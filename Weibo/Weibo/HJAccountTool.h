//
//  HJAccountTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJAccount;

@interface HJAccountTool : NSObject

+ (void)saveAccount:(HJAccount *)account;

+ (HJAccount *)account;

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure;

@end
