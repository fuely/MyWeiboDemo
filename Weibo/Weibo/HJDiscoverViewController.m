//
//  HJDiscoverViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJDiscoverViewController.h"
#import "HJSearchBar.h"
#import "HJBaseSetting.h"
#import "HJProfileCell.h"

@interface HJDiscoverViewController ()

@end

@implementation HJDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavBar];
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];

}

- (void)setUpGroup0
{
    // 热门微博
    HJBadgeItem *hotStatus = [HJBadgeItem itemWithTitle:@"热门微博" withImage:[UIImage imageNamed:@"hot_status"]];
    hotStatus.subTitle = @"全站最热微博尽搜罗";
    // 找人
    HJBadgeItem *findPeople= [HJBadgeItem itemWithTitle:@"找人" withImage:[UIImage imageNamed:@"find_people"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[hotStatus,findPeople];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 玩游戏
    HJBadgeItem *gameCenter = [HJBadgeItem itemWithTitle:@"玩游戏" withImage:[UIImage imageNamed:@"game_center"]];
    // 周边
    HJBadgeItem *near= [HJBadgeItem itemWithTitle:@"周边" withImage:[UIImage imageNamed:@"near"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[gameCenter,near];
    [self.groups addObject:group];
}

- (void)setUpGroup2
{
    //电影
    HJBadgeItem *movie = [HJBadgeItem itemWithTitle:@"电影" withImage:[UIImage imageNamed:@"movie"]];
    movie.subTitle = @"优惠电影票就在这里";
    //音乐精选
    HJBadgeItem *music = [HJBadgeItem itemWithTitle:@"音乐精选" withImage:[UIImage imageNamed:@"music"]];
    music.subTitle = @"热门音乐精选排行";
    // 直播
    HJBadgeItem *video = [HJBadgeItem itemWithTitle:@"直播" withImage:[UIImage imageNamed:@"video"]];
    video.subTitle = @"女生明星视频直播中";
    // 更多频道
    HJBadgeItem *more= [HJBadgeItem itemWithTitle:@"更多频道" withImage:[UIImage imageNamed:@"more"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[movie,music,video,more];
    [self.groups addObject:group];
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

- (void)setUpNavBar
{
    //创建搜索框
    HJSearchBar *searchBar = [[HJSearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 32)];
    self.navigationItem.titleView = searchBar;
}

@end
