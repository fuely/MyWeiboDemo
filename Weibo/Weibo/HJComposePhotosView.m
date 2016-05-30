//
//  HJComposePhotosView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/30.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposePhotosView.h"

@implementation HJComposePhotosView

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    [self.images addObject:image];
}

//每添加一个字控件时候也会调用,特殊:如果在viewDidLoad添加子控件,就不会调用;
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat marign = 10;
    CGFloat wh = (self.width - (cols - 1)*marign) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i< self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (marign + wh);
        y = row * (marign + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
}
@end
