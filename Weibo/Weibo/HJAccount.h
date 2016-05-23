//
//  HJAccount.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJAccount : NSObject<NSCoding>

/**
 *  获取授权后的access token
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *expires_time;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;



@end
