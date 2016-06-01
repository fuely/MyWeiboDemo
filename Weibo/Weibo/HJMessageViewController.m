//
//  HJMessageViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJMessageViewController.h"
#import "HJMessageCell.h"
#import "HJBaseSetting.h"
#import "HJSearchBar.h"

@interface HJMessageViewController ()

@end

@implementation HJMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = chat;
    [self setUpGroup0];
}

- (void)setUpGroup0
{
    //@我的
    HJArrowItem *my = [HJArrowItem itemWithTitle:@"@我的" withImage:[UIImage imageNamed:@"message_my"]];
    //评论
    HJArrowItem *comment = [HJArrowItem itemWithTitle:@"评论" withImage:[UIImage imageNamed:@"message_comment"]];
    //赞
    HJArrowItem *like = [HJArrowItem itemWithTitle:@"赞" withImage:[UIImage imageNamed:@"message_like"]];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[my,comment,like];
    [self.groups addObject:group];
}


#pragma mark - UITabelViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        HJSearchBar *searchBar = [[HJSearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 32)];
        [tableView.tableHeaderView addSubview:searchBar];
    }
    HJGroupItem *group = self.groups[section];
    return group.headedTitle;
}


@end
