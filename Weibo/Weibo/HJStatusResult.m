//
//  HJStatusResult.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJStatusResult.h"
#import "MJExtension.h"
#import "HJStatus.h"

@implementation HJStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[HJStatus class]};
}

@end
