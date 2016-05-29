//
//  HJPhotoView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJPhotoView.h"
#import "HJPhoto.h"
#import "UIImageView+WebCache.h"

@interface HJPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation HJPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置视图的内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        //允许交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImageView *gifV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        _gifView = gifV;
        
        [self addSubview:gifV];
    }
    return _gifView;
}

- (void)setPhoto:(HJPhoto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //判断是否显示gif
    if ([_photo.thumbnail_pic.absoluteString hasSuffix:@".gif"]) { // gif图片
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end

