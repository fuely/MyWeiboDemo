//
//  HJPopView.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/2.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJPopView.h"

#define HJMarginX 5
#define HJMarginY 13
@interface HJPopView()

@property (nonatomic, weak) UIImageView *containView;

@end

@implementation HJPopView


- (UIImageView *)containView
{
    if (_containView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage resizableWithImageName:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _containView = imageView;
    }
    return _containView;
}

+ (instancetype)popView
{
    HJPopView *p = [[HJPopView alloc] initWithFrame:HJKeyWindow.bounds];
    
    return p;
}

- (void)showInRect:(CGRect)rect
{
    self.containView.frame = rect;
    
    [HJKeyWindow addSubview:self];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    [self.containView addSubview:_contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = HJMarginX;
    CGFloat y = HJMarginY;
    CGFloat w = _containView.width - HJMarginX * 2;
    CGFloat h = _containView.height - HJMarginY * 2;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
        [_delegate popViewDidDismiss:self];
    }
}

@end
