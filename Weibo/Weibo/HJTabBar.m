//
//  HJTabBar.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJTabBar.h"
#import "HJTabBarButton.h"

@interface HJTabBar()

@property (nonatomic, weak) UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *tabBarbuttons;

@property (nonatomic, strong) UIButton *selctedButton;

@end

@implementation HJTabBar

- (NSMutableArray *)tabBarbuttons
{
    if (_tabBarbuttons == nil) {
        _tabBarbuttons = [NSMutableArray array];
    }
    return _tabBarbuttons;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        
        [button addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        _addButton = button;

    }
    return _addButton;
}

- (void)clickAddBtn
{
    if ([_delegate respondsToSelector:@selector(tabBarDidClickAddBtn:)]) {
        [_delegate tabBarDidClickAddBtn:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    HJTabBarButton *button = [HJTabBarButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    
    // 监听按钮点击
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    button.tag = self.tabBarbuttons.count;
    
    if (self.tabBarbuttons.count == 0) {
        [self btnClick:button];
    }
    
    [self addSubview:button];
    
    [self.tabBarbuttons addObject:button];
}

- (void)btnClick:(UIButton *)button
{
    _selctedButton.selected = NO;
    button.selected = YES;
    _selctedButton = button;
    
    
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]) {
        [_delegate tabBar:self didSelectedIndex:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置内部按钮的位置
    [self setUpAllTabBarButtonFrame];
    
    // 设置加号按钮的位置
    [self setUpAddButtonFrame];
}

- (void)setUpAddButtonFrame
{
    CGFloat centerX = self.width * 0.5;
    CGFloat centerY = self.height * 0.5;
    self.addButton.size = [self.addButton backgroundImageForState:UIControlStateNormal].size;
    self.addButton.center = CGPointMake(centerX, centerY);
}

- (void)setUpAllTabBarButtonFrame
{
    NSInteger i = 0;
    NSInteger count = self.tabBarbuttons.count + 1;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (UIView *tabBarButton in self.tabBarbuttons) {
        
        if (i == 2) { // 当第二个之后，都往后挪动一个按钮位置
            i += 1;
        }
        tabBarButton.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        
        i++;
        
        
    }
    
}



@end
