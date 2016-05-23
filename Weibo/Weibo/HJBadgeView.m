//
//  HJBadgeView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJBadgeView.h"

#define BadgeTitleFont [UIFont systemFontOfSize:11]

@implementation HJBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        self.titleLabel.font = BadgeTitleFont;
        self.size = backgroundImage.size;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    if (badgeValue == nil || [badgeValue isEqualToString:@""] || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    CGFloat titleW = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : BadgeTitleFont} context:nil].size.width;
    if (titleW > self.width) {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}



@end
