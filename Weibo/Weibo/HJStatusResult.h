//
//  HJStatusResult.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStatusResult : NSObject

/**
 *  用户最近的微博总数
 */
@property (nonatomic, assign) long long total_number;
/**
 *  用户微博数组(HJStatus)
 */
@property (nonatomic, strong) NSArray *statuses;

@end
