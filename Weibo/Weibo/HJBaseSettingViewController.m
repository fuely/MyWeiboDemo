//
//  HJBaseSettingViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJBaseSettingViewController.h"
#import "HJGroupItem.h"
#import "HJSettingCell.h"
#import "HJSettingItem.h"

@interface HJBaseSettingViewController ()

@end


@implementation HJBaseSettingViewController

//重写init,让我们控制器一出来就是group样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HJColor(211, 211, 211);
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - Table view data source
//返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

//返回一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HJGroupItem *group = self.groups[section];
    return group.items.count;
}

//返回每一行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    HJSettingCell *cell = [HJSettingCell cellwithTableView:tableView];
    
    //2.给cell传递模型
    HJGroupItem *group = self.groups[indexPath.section];
    HJSettingItem *item = group.items[indexPath.row];
    cell.item = item;
     
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HJGroupItem *group = self.groups[section];
    return group.headedTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    HJGroupItem *group = self.groups[section];
    return group.footerTiTle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中这一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取模型
    HJGroupItem *groupItem = self.groups[indexPath.section];
    HJSettingItem *item = groupItem.items[indexPath.row];
    if (item.option) {
        item.option((HJCheakItem *)item);
        return;
    }
    
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
