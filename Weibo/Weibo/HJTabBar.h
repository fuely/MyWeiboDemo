//
//  HJTabBar.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJTabBar;

@protocol HJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(HJTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex;
- (void)tabBarDidClickAddBtn:(HJTabBar *)tabBar;

@end

@interface HJTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic,weak) id<HJTabBarDelegate> delegate;

@end
