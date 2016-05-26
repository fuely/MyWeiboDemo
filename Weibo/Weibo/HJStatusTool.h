//
//  HJStatusTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/26.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStatusTool : NSObject

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

@end
