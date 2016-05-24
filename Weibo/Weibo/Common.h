//
//  Common.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#define HJKeyWindow [UIApplication sharedApplication].keyWindow

#define HJNavgationBarTitleFont [UIFont boldSystemFontOfSize:20]

#ifdef DEBUG
#define HJLog(...) NSLog(__VA_ARGS__)

#else

#define HJLog(...)
#endif


