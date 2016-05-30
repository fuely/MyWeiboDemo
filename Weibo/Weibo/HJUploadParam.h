//
//  HJUploadParam.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJUploadParam : NSObject

/**
 * 要上传的文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 * 上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 * 上传的参数名称
 */
@property (nonatomic, copy) NSString *paramName;
/**
 * 文件类型
 */
@property (nonatomic, copy) NSString *mineType;

@end
