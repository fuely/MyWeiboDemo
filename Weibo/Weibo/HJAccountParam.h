//
//  HJAccountParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJAccountParam : NSObject

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *grant_type;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *redirect_uri;

@end
