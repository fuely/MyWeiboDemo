//
//  HJProfileViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJProfileViewController.h"
#import "HJBaseSetting.h"
#import "HJProfileCell.h"

#import "HJSettingViewController.h"

@interface HJProfileViewController ()

@end

@implementation HJProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNav];

    //添加group0
    [self setUpGroup0];
    //添加group1
    [self setUpGroup1];
    //添加group2
    [self setUpGroup2];
    //添加group3
    [self setUpGroup3];
    //添加group4
    [self setUpGroup4];
}

- (void)setUpGroup0
{
    //新的好友
    HJArrowItem *friend = [HJArrowItem itemWithTitle:@"新的好友" withImage:[UIImage imageNamed:@"new_friend"]];
    //新手任务
    HJArrowItem *task = [HJArrowItem itemWithTitle:@"新手任务" withImage:[UIImage imageNamed:@"collect"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[friend,task];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 我的相册
    HJArrowItem *album = [HJArrowItem itemWithTitle:@"我的相册" withImage:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    //我的赞
    HJArrowItem *like = [HJArrowItem itemWithTitle:@"我的赞" withImage:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[album,like];
    [self.groups addObject:group];
}

- (void)setUpGroup2
{
    //微博支付
    HJArrowItem *pay = [HJArrowItem itemWithTitle:@"微博支付" withImage:[UIImage imageNamed:@"pay"]];
    pay.subTitle = @"用众筹,向梦想致敬!";
    //微博运动
    HJArrowItem *sport = [HJArrowItem itemWithTitle:@"微博运动" withImage:[UIImage imageNamed:@"vip"]];
    sport.subTitle = @"奔跑2016搬到这里来";
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[pay,sport];
    [self.groups addObject:group];
    
}

- (void)setUpGroup3
{
    //草稿箱
    HJArrowItem *draft = [HJArrowItem itemWithTitle:@"草稿箱" withImage:[UIImage imageNamed:@"draft"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[draft];
    [self.groups addObject:group];
    
}

- (void)setUpGroup4
{
    //更多
    HJArrowItem *more = [HJArrowItem itemWithTitle:@"更多" withImage:[UIImage imageNamed:@"card"]];
    more.subTitle = @"数据中心,点评,收藏";
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[more];
    [self.groups addObject:group];
    
}




- (void)setUpNav
{
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = setting;
    
}

- (void)setting
{
 
    HJSettingViewController *settingVC = [[HJSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    HJProfileCell *cell = [HJProfileCell cellwithTableView:tableView];
    
    //2.给cell传递模型 
    HJGroupItem *group = self.groups[indexPath.section];
    HJSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}

@end
