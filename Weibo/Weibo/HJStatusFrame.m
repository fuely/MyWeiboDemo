//
//  HJStatusFrame.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJStatusFrame.h"
#import "HJStatus.h"
#import "HJUser.h"
#import "HJPhotosView.h"

#define HJScreenW [UIScreen mainScreen].bounds.size.width

@implementation HJStatusFrame

- (void)setStatus:(HJStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewF);
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetFrame];
        
        toolBarY = CGRectGetMaxY(_retweetedViewF);
    }
    
    // 计算工具条
    CGFloat toolBarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarH = 35;
    _toolBarViewF = CGRectMake(0, toolBarY, toolBarW, toolBarH);
    
    // 计算cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarViewF);
}


/**
 *  计算原创微博
 */
- (void)setUpOriginalFrame
{
    // 头像
    CGFloat iconX =HJCellMargin;
    CGFloat iconY = HJCellMargin + HJCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + HJCellMargin;
    CGFloat nameY = iconY;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = HJNameFont;
    CGSize nameSize = [_status.user.name sizeWithAttributes:nameDict];
    _nameViewF = (CGRect){{nameX,nameY},nameSize};
    
    // 会员
    if (_status.user.isVip) { // 是会员
        CGFloat vipX = CGRectGetMaxX(_nameViewF) + HJCellMargin;
        CGFloat vipW = 14;
        CGFloat vipH = 14;
        
        CGFloat vipY = nameY;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameViewF) ;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = HJTimeFont;
    CGSize timeSize = [_status.created_at sizeWithAttributes:timeDict];
    _timeViewF = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeViewF) + HJCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = HJSourceFont;
    CGSize sourceSize = [_status.source sizeWithAttributes:sourceDict];
    _sourceViewF = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 内容
    CGFloat textX = HJCellMargin;
    CGFloat textY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_nameViewF)) + HJCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = HJTextFont;
    CGSize textSize = [_status.text boundingRectWithSize:CGSizeMake(HJScreenW - HJCellMargin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    _textViewF = (CGRect){{textX,textY},textSize};
    
    // 原创微博frame
    CGFloat originH = CGRectGetMaxY(_textViewF) + HJCellMargin;
    
    // 配图
    if (_status.pic_urls.count) { // 有配图
        CGFloat photosX = HJCellMargin;
        CGFloat photosY = originH;
        CGSize photosSize = [HJPhotosView photosSizeWithCount:(int)_status.pic_urls.count];
        _photosViewF = (CGRect){{photosX,photosY},photosSize};
        
        originH = CGRectGetMaxY(_photosViewF) + HJCellMargin;
    }
    
    _originalViewF = CGRectMake(0, HJCellMargin, HJScreenW, originH);
    
}


/**
 *  计算转发微博
 */
- (void)setUpRetweetFrame
{
    // 昵称
    CGFloat nameX = HJCellMargin;
    CGFloat nameY = HJCellMargin;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = HJNameFont;
    NSString *retweetName = [NSString stringWithFormat:@"@%@",_status.retweeted_status.user.name];
    CGSize nameSize = [retweetName sizeWithAttributes:nameDict];
    _retweetNameViewF = (CGRect){{nameX,nameY},nameSize};
    
    
    // 内容
    CGFloat textX = HJCellMargin;
    CGFloat textY = CGRectGetMaxY(_retweetNameViewF) + HJCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = HJTextFont;
    CGSize textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(HJScreenW - HJCellMargin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    _retweetTextViewF = (CGRect){{textX,textY},textSize};
    
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextViewF) + HJCellMargin;
    
    // 配图
    if (_status.retweeted_status.pic_urls.count) { // 有配图
        CGFloat photosX = HJCellMargin;
        CGFloat photosY = retweetH;
        CGSize photosSize =[HJPhotosView photosSizeWithCount:(int)_status.retweeted_status.pic_urls.count];
        _retweetPhotosViewF = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosViewF) + HJCellMargin;
    }
    
    
    // 转发微博frame
    CGFloat retweetW = [UIScreen mainScreen].bounds.size.width;
    CGFloat retweetY = CGRectGetMaxY(_originalViewF);
    
    _retweetedViewF = CGRectMake(0, retweetY, retweetW, retweetH);
    
    
}



@end
