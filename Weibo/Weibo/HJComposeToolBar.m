//
//  HJComposeToolBar.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/30.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposeToolBar.h"

#define HJBtnCount 5
@implementation HJComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView
{
    //相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    
    //提及
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    //话题
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    //表情
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    //键盘
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}

- (void)setUpButtonWithImage :(UIImage *)image highImage:(UIImage *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = self.subviews.count;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

- (void)btnClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [_delegate composeToolBar:self didClickBtn:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width/HJBtnCount;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i*w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
