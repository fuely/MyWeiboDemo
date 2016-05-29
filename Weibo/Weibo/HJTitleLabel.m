//
//  HJTitleLabel.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/29.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJTitleLabel.h"

@interface HJTitleLabel()

@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation HJTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textColor = [UIColor lightGrayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:10];
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = @"发微博";
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _titleLabel = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width+=2;
    [super setFrame:frame];
}

@end
