//
//  HJPhotosView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJPhotosView.h"

#import "HJPhoto.h"
#import "HJPhotoView.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define HJPhotoCount 9

const CGFloat photoMargin = 10;
const CGFloat photoWH = 70;

@implementation HJPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllSubviews];
        
    }
    return self;
}
- (void)setUpAllSubviews
{
    for (int i = 0; i < HJPhotoCount; i++) {
        HJPhotoView *imageV = [[HJPhotoView alloc] init];
        imageV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = tap.view.tag;
    NSMutableArray *photos = [NSMutableArray array];
    
    for (HJPhoto *photo in _pic_urls) {
        
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = photo.thumbnail_pic;
        mjPhoto.srcImageView = (UIImageView *)tap.view;
        
        [photos addObject:mjPhoto];
    }
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int photosCount =(int)pic_urls.count;
    
    for (int i = 0; i < HJPhotoCount; i++) {
        HJPhotoView *imageV = self.subviews[i];
        
        if (i >= photosCount) { // 大于总的个数，就不需要显示
            imageV.hidden = YES;
        }else{
            HJPhoto *photo = self.pic_urls[i];
            imageV.photo = photo;
            
            imageV.hidden = NO;
        }
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int photosCount = (int)_pic_urls.count;
    
    int cols = photosCount == 4?2:3;
    int col = 0;
    int rol = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < photosCount; i++) {
        col = i % cols;
        rol = i / cols;
        x = col * (photoMargin + photoWH);
        y = rol * (photoMargin + photoWH);
        UIImageView *imgV = self.subviews[i];
        imgV.frame = CGRectMake(x, y, photoWH, photoWH);
        
    }
    
}

+ (CGSize)photosSizeWithCount:(int)count
{
    int cols = count == 4?2:3;
    int rols = (count - 1) / cols + 1;
    
    CGFloat photosW = (cols - 1) * photoMargin + cols * photoWH;
    CGFloat photosH = (rols - 1) * photoMargin + rols * photoWH;
    
    return CGSizeMake(photosW, photosH);
    
}


@end
