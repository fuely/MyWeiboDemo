//
//  HJTabBarController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJTabBarController.h"

#import "HJHomeViewController.h"
#import "HJMessageViewController.h"
#import "HJDiscoverViewController.h"
#import "HJProfileViewController.h"
#import "HJNavViewController.h"

#import "HJTabBar.h"

@interface HJTabBarController ()<HJTabBarDelegate>

@property (nonatomic, weak) HJTabBar *customTabBar;

@property (nonatomic, strong) HJHomeViewController *home;
@property (nonatomic, strong) HJMessageViewController *message;
@property (nonatomic, strong) HJProfileViewController *profile;


@property (nonatomic, assign) NSInteger selIndex;

@end

@implementation HJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.自定义tabBar
    [self setUpTabBar];
    
    // 2.添加子控制器
    [self setUpAllChildViewController];

}

// 设置tabBar
- (void)setUpTabBar
{
    HJTabBar *tabBar = [[HJTabBar alloc] init];
    
    tabBar.frame = self.tabBar.bounds;
    
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    
    tabBar.delegate = self;
    
    [self.tabBar addSubview:tabBar];
    
    _customTabBar = tabBar;
    
}

// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    HJHomeViewController *home = [[HJHomeViewController alloc] init];
    [self setUpOneChildViewController:home title:@"首页" imageName:@"tabbar_home" selImageName:@"tabbar_home_selected"];
    _home = home;
    
    // 消息
    HJMessageViewController *message = [[HJMessageViewController alloc] init];
    [self setUpOneChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selImageName:@"tabbar_message_center_selected"];
    _message = message;
    
    // 广场
    HJDiscoverViewController *discover = [[HJDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selImageName:@"tabbar_discover_selected"];
    
    
    // 我
    HJProfileViewController *profile = [[HJProfileViewController alloc] init];
    [self setUpOneChildViewController:profile title:@"我" imageName:@"tabbar_profile" selImageName:@"tabbar_profile_selected"];
    _profile = profile;
}

// 添加一个控制器的属性
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selImage = [UIImage imageNamed:selImageName];
//    if (iOS7) {
//        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
    
    vc.tabBarItem.selectedImage = selImage;
    
    HJNavViewController *nav = [[HJNavViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
    
}



@end
