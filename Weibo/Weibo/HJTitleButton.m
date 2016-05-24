//
//  HJTitleButton.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJTitleButton.h"

@implementation HJTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        
        self.titleLabel.font = HJNavgationBarTitleFont;
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage resizableWithImageName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width += 2;
    [super setFrame:frame];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 自动算好尺寸
    [self sizeToFit];
}


@end
