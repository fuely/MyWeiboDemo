//
//  HJUserUnreadResult.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJUserUnreadResult.h"

@implementation HJUserUnreadResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return self.messageCount + _follower  + _status;
}


@end
