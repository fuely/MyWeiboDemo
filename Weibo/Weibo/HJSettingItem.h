//
//  HJSettingItem.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/31.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//  描述每个cell长什么样子

#import <Foundation/Foundation.h>

@class HJCheakItem;

@interface HJSettingItem : NSObject

/**
 *  描述imageView
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  描述textlabel
 */
@property (nonatomic, copy) NSString *title;
/**
 *  描述detaillabel
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 * 保存每一行要做的事情
 */
@property (nonatomic, copy) void(^option)(HJCheakItem *item);
/**
 *  跳转控制器的类名
 */
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title withImage:(UIImage *)image;
+ (instancetype)itemWithTitle:(NSString *)title withSubTitle:(NSString *)subTitle withImage:(UIImage *)image;

@end
