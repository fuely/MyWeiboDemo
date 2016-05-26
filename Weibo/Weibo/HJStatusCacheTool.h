//
//  HJStatusCacheTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJStatusParam;

@interface HJStatusCacheTool : NSObject

+ (void)saveWithStatuses:(NSArray *)dictArr;

+ (NSArray *)statusesWithParam:(HJStatusParam *)param;

@end
