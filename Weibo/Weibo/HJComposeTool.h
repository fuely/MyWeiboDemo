//
//  HJComposeTool.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/30.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJComposeTool : NSObject

+ (void)composeWithSatausText:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *error))failure;

+ (void)composeWithImage:(UIImage *)image status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
