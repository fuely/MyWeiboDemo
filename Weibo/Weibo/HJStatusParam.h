//
//  HJStatusParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStatusParam : NSObject

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) id max_id;
@property (nonatomic, strong) id since_id;
@property (nonatomic, strong) id count;

@end
