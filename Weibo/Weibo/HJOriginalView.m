//
//  HJOriginalView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJOriginalView.h"

#import "HJStatus.h"
#import "HJStatusFrame.h"
#import "HJUser.h"
#import "HJPhotosView.h"

#import "UIImageView+WebCache.h"

@interface HJOriginalView()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak)  UILabel *textLabel;

@property (nonatomic, weak)  HJPhotosView *photosView;

@end

@implementation HJOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableWithImageName:@"timeline_card_top_background"];
    }
    return self;
}

- (void)setUpAllSubviews
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HJNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    // 会员
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 微博时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = HJTimeFont;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = HJSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    // 内容
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.font = HJTextFont;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    // 配图
    HJPhotosView *photosView = [[HJPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(HJStatusFrame *)statusF
{
    _statusF = statusF;
    
    self.frame = statusF.originalViewF;
    
    HJStatus *status = statusF.status;
    
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    _iconView.frame = statusF.iconViewF;
    
    // 昵称
    _nameLabel.text = statusF.status.user.name;
    _nameLabel.frame = statusF.nameViewF;
    
    // 会员
    if (status.user.isVip) { // 是会员
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        _vipView.image = [UIImage imageNamed:vipName];
        _vipView.frame = statusF.vipViewF;
        _vipView.hidden = NO;
        _nameLabel.textColor = [UIColor orangeColor];
    }else{
        _nameLabel.textColor = [UIColor blackColor];
        _vipView.hidden = YES;
    }
    
    //实时修改时间与来源frame
    // 时间frame
    CGFloat timeX = statusF.nameViewF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusF.nameViewF) ;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = HJTimeFont;
    CGSize timeSize = [status.created_at sizeWithAttributes:timeDict];
    _timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 微博时间
    _timeLabel.text = status.created_at;
    if ([status.created_at isEqualToString:@"刚刚"]) {
        _timeLabel.textColor = [UIColor orangeColor];
    }else{
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    
    // 来源
    _sourceLabel.text = status.source;
    
    // 来源frame
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + HJCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = HJSourceFont;
    CGSize sourceSize = [status.source sizeWithAttributes:sourceDict];
    _sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    // 内容
    _textLabel.text= status.text;
    _textLabel.frame = statusF.textViewF;
    
    
    // 配图
    if (status.pic_urls.count) { // 有配图
        _photosView.pic_urls = status.pic_urls;
        _photosView.frame = statusF.photosViewF;
        _photosView.hidden = NO;
    }else{
        _photosView.hidden = YES;
    }
    
}


@end
