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

#import "HJComposeViewController.h"

#import "HJTabBar.h"

#import "HJUserTool.h"
#import "HJUserUnreadResult.h"

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
    
    //每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnRead) userInfo:nil repeats:YES];
}

//请求未读数时调用
-(void)requestUnRead
{
    //请求微博的未度数
    [HJUserTool unreadCountDidsuccess:^(HJUserUnreadResult *unread) {
        
        //设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unread.status];
        
        //设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unread.messageCount];
        
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unread.follower];
        
        //设置应用程序的所有未读书
        [UIApplication sharedApplication].applicationIconBadgeNumber = unread.totalCount;
        
    } failure:^(NSError *error) {
        
    }];

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

#pragma mark - 点击TabBar上的按钮调用
- (void)tabBar:(HJTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex == 0 && selectedIndex == _selIndex ) { // 点击首页 刷新首页
        // 刷新数据
        [_home refresh];
    }
    
    self.selectedIndex = selectedIndex;
    
    _selIndex = selectedIndex;
}

- (void)tabBarDidClickAddBtn:(HJTabBar *)tabBar
{
    HJComposeViewController *compose = [[HJComposeViewController alloc] init];
    HJNavViewController *nav = [[HJNavViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
