//
//  HJWeibocfg.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

// extern声明一个变量，就会自动去查找，对应的只读变量的值
extern NSString *const HJAppKey;
extern NSString *const HJAppSecret;
extern NSString *const HJRedirectUrl;

extern NSString *const HJAccessTokenUrl;

/**
 *  登录网页URL
 *
 */
#define HJResquestTokeURLStr  [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",HJAppKey,HJRedirectUrl]