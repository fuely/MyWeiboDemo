//
//  HJComposeToolBar.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/30.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    HJComposeToolBarButtonTypeCamera,
    HJComposeToolBarButtonTypeMention,
    HJComposeToolBarButtonTypeTrend,
    HJComposeToolBarButtonTypeEmoticon,
    HJComposeToolBarButtonTypeKeyboard
}HJComposeToolBarButtonType;

@class HJComposeToolBar;

@protocol HJComposeToolBarDelegate <NSObject>

@optional

- (void)composeToolBar:(HJComposeToolBar *)toolBar didClickBtn:(HJComposeToolBarButtonType)type;

@end

@interface HJComposeToolBar : UIView

@property (nonatomic, weak) id<HJComposeToolBarDelegate> delegate;

@end
