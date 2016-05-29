//
//  HJPhotosView.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//  相册的View 包含所有的配图View

#import <UIKit/UIKit.h>

@interface HJPhotosView : UIView

@property (nonatomic, strong) NSArray *pic_urls;

+ (CGSize)photosSizeWithCount:(int)count;

@end
