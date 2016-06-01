//
//  HJSettingItem.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/31.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJSettingItem.h"

@implementation HJSettingItem

+(instancetype)itemWithTitle:(NSString *)title withSubTitle:(NSString *)subTitle withImage:(UIImage *)image
{
    HJSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    item.image = image;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title withImage:(UIImage *)image
{
    return [self itemWithTitle:title withSubTitle:nil withImage:image];
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title withSubTitle:nil withImage:nil];
}

@end
