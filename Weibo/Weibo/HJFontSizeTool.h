//
//  HJFontSizeTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJFontSizeTool : NSObject

//存储字体
+ (void)saveFontSize:(NSString *)fontSize;
//获取字体
+ (NSString *)fontSize;

@end
