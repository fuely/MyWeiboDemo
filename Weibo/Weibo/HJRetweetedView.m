//
//  HJRetweetedView.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJRetweetedView.h"
#import <objc/message.h>

#import "HJStatus.h"
#import "HJStatusFrame.h"
#import "HJUser.h"
#import "HJPhotosView.h"

@interface HJRetweetedView()

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak)  UILabel *textLabel;

@property (nonatomic, weak)  HJPhotosView *photosView;

@end

@implementation HJRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableWithImageName:@"timeline_retweet_background"];
        
        
    }
    return self;
}

- (void)setUpAllSubviews
{
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = HJColor(85, 105, 144);
    _nameLabel = nameLabel;
    nameLabel.font = HJNameFont;
    [self addSubview:nameLabel];
    
    // 内容
    UILabel *textLabel = [[UILabel alloc] init];
    _textLabel.font = HJTextFont;
    _textLabel = textLabel;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    
    // 配图
    HJPhotosView *photosView = [[HJPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}




- (void)setStatusF:(HJStatusFrame *)statusF
{
    _statusF = statusF;
    HJStatus *status = statusF.status;
    
    self.frame = statusF.retweetedViewF;
    
    // 昵称
    _nameLabel.text = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
    _nameLabel.frame = statusF.retweetNameViewF;
    
    // 内容
    _textLabel.text= status.retweeted_status.text;
    _textLabel.frame = statusF.retweetTextViewF;
    
    // 配图
    if (status.retweeted_status.pic_urls.count) { // 有配图
        _photosView.pic_urls = status.retweeted_status.pic_urls;
        _photosView.frame = statusF.retweetPhotosViewF;
        _photosView.hidden = NO;
    }else{
        _photosView.hidden = YES;
    }
    
}



@end
