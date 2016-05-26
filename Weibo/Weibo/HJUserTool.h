//
//  HJUserTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJUser,HJUserUnreadResult;

@interface HJUserTool : NSObject

+ (void)userInfoDidsuccess:(void (^)(HJUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)unreadCountDidsuccess:(void (^)(HJUserUnreadResult *user))success failure:(void (^)(NSError *error))failure;

@end
