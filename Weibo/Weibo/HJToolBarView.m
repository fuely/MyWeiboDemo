//
//  HJToolBarView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJToolBarView.h"
#import "HJStatus.h"

@interface HJToolBarView()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divides;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation HJToolBarView

- (NSMutableArray *)divides
{
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setUpAllSubviews
{
    // 添加转发
    _retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    
    // 添加评论
    _comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    
    // 添加赞
    _unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
    // 添加分割线
    [self setUpDivide];
}
- (void)setUpDivide
{
    for (int i = 0; i < 2; i++) {
        UIImageView *divide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divide];
        [self.divides addObject:divide];
    }
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self.btns addObject:btn];
    
    [self addSubview:btn];
    return btn;
}

- (void)clickBtn:(UIButton *)btn
{
    if (btn == _unlike) {
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        if (btn.selected) {
            [self setBtnTitleWithCount:_status.attitudes_count setBtn:btn];
        }else{
            [self setBtnTitleWithCount:_status.attitudes_count+1 setBtn:btn];
        }
            btn.selected = !btn.selected;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮位置
    NSUInteger btnCount = self.btns.count;
    CGFloat w = self.width / btnCount;
    CGFloat h = self.height;
    CGFloat x = 0;
    for (int i = 0; i < btnCount; i++) {
        x = i * w;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, 0, w, h);
    }
    
    // 设置分割线位置
    NSUInteger divideCount = self.divides.count;
    for (int i = 0;i < divideCount ; i ++) {
        UIImageView * divideV = self.divides[i];
        UIButton *btn = self.btns[i + 1];
        divideV.x = btn.x;
    }
    
    
}

- (void)setStatus:(HJStatus *)status
{
    _status = status;
    
    // 转发
    [self setBtnTitleWithCount:status.reposts_count setBtn:_retweet];
    // 评论
    [self setBtnTitleWithCount:status.comments_count setBtn:_comment];
    // 赞
    [self setBtnTitleWithCount:status.attitudes_count setBtn:_unlike];
    _unlike.selected = NO;

    
}

#pragma mark - 设置转发,评论,赞的数目
- (void)setBtnTitleWithCount:(int)count setBtn:(UIButton *)btn
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end

