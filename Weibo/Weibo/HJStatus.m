//
//  HJStatus.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJStatus.h"
#import "HJPhoto.h"

#import "MJExtension.h"
#import "NSDate+MJ.h"


@implementation HJStatus

//实现这个方法, 就会自动把数组中的字典转换成对应的模型
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[HJPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
#warning 真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    // 获取微博创建时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    if ([createDate isThisYear]) { // 判断是否今年
        
        if ([createDate isToday]) { // 今天
            
            // 获取时间差
            NSDateComponents *cmp =  [createDate deltaWithNow];
            
            if (cmp.hour >= 1) { // 至少1小时
                return [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
            }else if (cmp.minute > 1){ // 1~60分钟内发的
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
            }else{
                return @"刚刚";
            }
            
            
        }else if ([createDate isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            
            return [fmt stringFromDate:createDate];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            
            return [fmt stringFromDate:createDate];
        }
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd";
        
        return [fmt stringFromDate:createDate];
    }

}

- (void)setSource:(NSString *)source
{
    if ([source isEqualToString:@""]) return;
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + 1];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    
    _source = [NSString stringWithFormat:@"来自%@",source];
}



@end
