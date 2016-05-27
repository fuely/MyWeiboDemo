//
//  HJUserParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//  用户未读数请求的参数模型

#import <Foundation/Foundation.h>

@interface HJUserParam : NSObject

@property (nonatomic, copy) NSString *access_token;
/**
 *  获取消息未读数的用户UID
 */
@property (nonatomic, copy) NSString *uid;

@end
