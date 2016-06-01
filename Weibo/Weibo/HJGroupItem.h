//
//  HJGroupItem.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/31.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//  描述每一组长什么样子

#import <Foundation/Foundation.h>

@interface HJGroupItem : NSObject

/**
 *  一组有多少行cell(HJSettingItem)
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headedTitle;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerTiTle;

@end
