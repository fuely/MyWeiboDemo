//
//  HJSettingViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJSettingViewController.h"
#import "HJBaseSetting.h"
#import "HJCommonSettingViewController.h"

@interface HJSettingViewController ()

@end

@implementation HJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    // 账号管理
    HJBadgeItem *account = [HJBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"10";
    // 账号安全
    HJBadgeItem *safety = [HJBadgeItem itemWithTitle:@"账号安全"];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[account,safety];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 提醒和通知
    HJArrowItem *notice = [HJArrowItem itemWithTitle:@"通知"];
    // 隐私
    HJArrowItem *secure = [HJArrowItem itemWithTitle:@"隐私" ];
    // 通用设置
    HJArrowItem *setting = [HJArrowItem itemWithTitle:@"通用设置" ];
    setting.destVcClass = [HJCommonSettingViewController class];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[notice,secure,setting];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 清理缓存
    HJArrowItem *cache = [HJArrowItem itemWithTitle:@"清理缓存" ];
    cache.subTitle = @"127M";
    // 意见反馈
    HJArrowItem *suggest = [HJArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    HJArrowItem *about = [HJArrowItem itemWithTitle:@"关于微博"];
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[cache,suggest,about];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 账号管理
    HJLabelItem *logout = [[HJLabelItem alloc] init];
    logout.text = @"退出当前账号";
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[logout];
    [self.groups addObject:group];
}

@end
