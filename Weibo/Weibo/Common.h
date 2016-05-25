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

#define HJColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

/*******StatusCell ******/
#define HJCellMargin 10
#define HJNameFont [UIFont systemFontOfSize:15]
#define HJTimeFont [UIFont systemFontOfSize:12]
#define HJSourceFont [UIFont systemFontOfSize:12]
#define HJTextFont [UIFont systemFontOfSize:18]



