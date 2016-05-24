//
//  HJNavViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJNavViewController.h"
#import "HJTabBar.h"


@interface HJNavViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation HJNavViewController

// 这个方法调用：第一次使用本类或者他的子类会调用
+ (void)initialize
{
    if (self == [HJNavViewController class]) {
        // 设置导航条的标题
        [self setUpNavBarTitle];
        
        // 设置导航条的按钮
        [self setUpNavBarButton];
    }
}

+ (void)setUpNavBarButton
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置不可用状态下的按钮颜色
    NSMutableDictionary *disableDictM = [NSMutableDictionary dictionary];
    disableDictM[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableDictM forState:UIControlStateDisabled];
    
    NSMutableDictionary *normalDictM = [NSMutableDictionary dictionary];
    normalDictM[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 设置普通状态下的按钮颜色
    [item setTitleTextAttributes:normalDictM forState:UIControlStateNormal];
    
    
}

// 设置导航条的标题
+ (void)setUpNavBarTitle
{
    
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[HJNavViewController class]]];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = HJNavgationBarTitleFont;
    [nav setTitleTextAttributes:dictM];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {// 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条的按钮
        UIBarButtonItem *popPre = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(popToPre)];
        viewController.navigationItem.leftBarButtonItem = popPre;
        
        UIBarButtonItem *popRoot = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(popToRoot)];
        viewController.navigationItem.rightBarButtonItem = popRoot;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[HJTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {//显示根控制器
        
        //还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{//不是显示根控制器
        
        //实现滑动返回功能,清空代理
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
