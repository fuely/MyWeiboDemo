//
//  HJComposeTextView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/29.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposeTextView.h"

@interface HJComposeTextView ()

@property (nonatomic, weak) UILabel *placeTextLabel;

@end

@implementation HJComposeTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeTextLabel.hidden = hidePlaceHolder;
    
}

- (UILabel *)placeTextLabel
{
    if (_placeTextLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _placeTextLabel = label;
        [self addSubview:label];
    }
    return _placeTextLabel;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];
    self.placeTextLabel.text = placeHolder;
    self.placeTextLabel.textColor = [UIColor lightGrayColor];
    //label的尺寸跟文字一样
    [self.placeTextLabel sizeToFit];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeTextLabel.x = 5;
    self.placeTextLabel.y = 8;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeTextLabel.font = font;
}
@end
