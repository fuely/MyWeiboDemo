//
//  HJUser.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJUser : NSObject

/**
 *  用户显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;


@end
