//
//  HJAccount.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJAccount.h"

#define HJAccessTokenKey @"access_token"
#define HJExpiresInKey @"expires_in"
#define HJExpiresTimeKey @"expires_time"
#define HJUidKey @"uid"
#define HJNameKey @"name"

@implementation HJAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    HJAccount *account = [[self alloc]init];
    account.expires_in = dict[HJExpiresInKey];
    account.uid = dict[HJUidKey];
    account.access_token = dict[HJAccessTokenKey];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    NSDate *date = [NSDate date];
    _expires_time = [date dateByAddingTimeInterval:[expires_in longLongValue]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:HJAccessTokenKey];
    [aCoder encodeObject:_expires_in forKey:HJExpiresInKey];
    [aCoder encodeObject:_expires_time forKey:HJExpiresTimeKey];
    [aCoder encodeObject:_uid forKey:HJUidKey];
    [aCoder encodeObject:_name forKey:HJNameKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:HJAccessTokenKey];
        _expires_time = [aDecoder decodeObjectForKey:HJExpiresTimeKey];
        _expires_in = [aDecoder decodeObjectForKey:HJExpiresInKey];
        _uid = [aDecoder decodeObjectForKey:HJUidKey];
        _name = [aDecoder decodeObjectForKey:HJNameKey];
    }
    return self;
}


@end
