//
//  HJStatusResult.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStatusResult : NSObject

@property (nonatomic, assign) long long total_number;

@property (nonatomic, strong) NSArray *statuses;

@end
