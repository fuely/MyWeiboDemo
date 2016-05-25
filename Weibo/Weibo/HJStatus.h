//
//  HJStatus.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJUser;

@interface HJStatus : NSObject

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博作者的用户信息
 */
@property (nonatomic, strong) HJUser *user;
/**
 *  被转发的原微博信息
 */
@property (nonatomic, strong) HJStatus *retweeted_status;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博配图地址
 */
@property (nonatomic, strong) NSArray *pic_urls;


@end
