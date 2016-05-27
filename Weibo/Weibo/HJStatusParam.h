//
//  HJStatusParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStatusParam : NSObject

//参数模型如何设计,直接参照接口文档的参数列表
/**
 *   OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *   max_id	此参数，则返回ID小于或等于max_id的微博
 */
@property (nonatomic, strong) id max_id;
/**
 *   此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博）
 */
@property (nonatomic, strong) id since_id;
/**
 *   单页返回的记录条数，最大不超过100，默认为20
 */
@property (nonatomic, strong) id count;

@end
