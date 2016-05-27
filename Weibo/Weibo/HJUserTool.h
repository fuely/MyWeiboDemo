//
//  HJUserTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//  处理用户的业务

#import <Foundation/Foundation.h>

@class HJUser,HJUserUnreadResult;

@interface HJUserTool : NSObject

+ (void)userInfoDidsuccess:(void (^)(HJUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)unreadCountDidsuccess:(void (^)(HJUserUnreadResult *unread))success failure:(void (^)(NSError *error))failure;

@end
