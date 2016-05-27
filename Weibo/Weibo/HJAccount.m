//
//  HJAccount.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJAccount.h"

#import "MJExtension.h"

#define HJAccessTokenKey @"access_token"
#define HJExpiresInKey @"expires_in"
#define HJExpiresTimeKey @"expires_time"
#define HJUidKey @"uid"
#define HJNameKey @"name"

@implementation HJAccount

//底层遍历当前类的所有属性,一个一个归档和解档
MJCodingImplementation

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
    
    //计算过期时间 = 当前时间 + 有效期
    NSDate *date = [NSDate date];
    _expires_time = [date dateByAddingTimeInterval:[expires_in longLongValue]];
}
/*
//归档的时候调用:告诉系统哪个属性需要归档,如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:HJAccessTokenKey];
    [aCoder encodeObject:_expires_in forKey:HJExpiresInKey];
    [aCoder encodeObject:_expires_time forKey:HJExpiresTimeKey];
    [aCoder encodeObject:_uid forKey:HJUidKey];
    [aCoder encodeObject:_name forKey:HJNameKey];
}

//解档的时候调用:告诉系统哪个属性需要解档,如何解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //一定要赋值 
        _access_token = [aDecoder decodeObjectForKey:HJAccessTokenKey];
        _expires_time = [aDecoder decodeObjectForKey:HJExpiresTimeKey];
        _expires_in = [aDecoder decodeObjectForKey:HJExpiresInKey];
        _uid = [aDecoder decodeObjectForKey:HJUidKey];
        _name = [aDecoder decodeObjectForKey:HJNameKey];
    }
    return self;
}
*/


@end
