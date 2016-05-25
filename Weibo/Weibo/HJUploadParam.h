//
//  HJUploadParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJUploadParam : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *paramName;
@property (nonatomic, copy) NSString *mineType;

@end
