//
//  HJFontSizeTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJFontSizeTool.h"

#define HJUserDefaults [NSUserDefaults standardUserDefaults]
#define HJFontSizeKey @"fontSizeKey"

@implementation HJFontSizeTool

//存储字体
+ (void)saveFontSize:(NSString *)fontSize
{
    [HJUserDefaults setObject:fontSize forKey:HJFontSizeKey];
    [HJUserDefaults synchronize];
}
//获取字体
+ (NSString *)fontSize
{
    return [HJUserDefaults objectForKey:HJFontSizeKey];
}


@end
