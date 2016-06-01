//
//  HJPopView.h
//  Weibo
//
//  Created by 傅韩建 on 16/6/2.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJPopView;

@protocol HJPopViewDelegate <NSObject>

@optional
- (void)popViewDidDismiss:(HJPopView *)popView;

@end

@interface HJPopView : UIView

+ (instancetype)popView;

- (void)showInRect:(CGRect)rect;

@property (nonatomic, weak) id<HJPopViewDelegate> delegate;

@property (nonatomic, weak) UIView *contentView;

@end
