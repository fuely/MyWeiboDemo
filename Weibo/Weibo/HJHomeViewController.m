//
//  HJHomeViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJHomeViewController.h"
#import "HJTitleButton.h"

#import "HJStatus.h"
#import "HJUser.h"
#import "HJStatusFrame.h"
#import "HJStatusCell.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

#import "AFNetworking.h"
#import "HJAccountTool.h"
#import "HJAccount.h"
#import "MJExtension.h"

const int navHeight = 64;

@interface HJHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrameArr;
@property (nonatomic, weak) HJTitleButton *titleButton;

@end

@implementation HJHomeViewController

- (NSMutableArray *)statusFrameArr
{
    if (_statusFrameArr == nil) {
        _statusFrameArr = [NSMutableArray array];
    }
    return _statusFrameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条的内容
    [self setUpNavBar];

    // 添加刷新控件
    [self setUpRefreshView];
    
    // 开始刷新
    [self.tableView headerBeginRefreshing];
    
    self.tableView.backgroundColor = HJColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setUpRefreshView
{
    // 添加下拉刷新控件
    typeof(self) homeVc = self;
    [self.tableView addHeaderWithCallback:^{
        [homeVc loadNewStatuses];
    }];
    
    // 添加上拉加载更多
    [self.tableView addFooterWithCallback:^{
        [homeVc loadMoreStatuses];
    }];
}

- (void)loadMoreStatuses
{
    /*
    HJStatusFrame *statusF = [self.statusFrameArr lastObject];
    id maxID = nil;
    if (statusF.status.idstr) {
        maxID = @([statusF.status.idstr longLongValue] - 1);
    }
    
    [HJStatusTool moreStatusesWithID:maxID success:^(NSArray *statusFrameArr) {
        
        [self.statusFrameArr addObjectsFromArray:statusFrameArr];
        
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        
    }];
     */
}

- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}


- (void)loadNewStatuses
{
/*
    HJStatusFrame *statusF = [self.statusFrameArr firstObject];
    id sinceID = nil;
    if (statusF.status.idstr) {
        sinceID = statusF.status.idstr;
    }
    [HJStatusTool newStatusesWithID:sinceID success:^(NSArray *statusFrameArr) {
        
        // 提示最新微博数据
        NSInteger count = statusFrameArr.count;
        [self showNewStatusesCount:count];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)];
        [self.statusFrameArr insertObjects:statusFrameArr atIndexes:indexSet];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        
    }];
*/
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HJAccountTool account].access_token;
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //把字典数组转换成模型数组
        NSArray *dictArr = responseObject[@"statuses"];
        self.statusFrameArr = (NSMutableArray *)[HJStatus objectArrayWithKeyValuesArray:dictArr];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

// 显示最新微博数
- (void)showNewStatusesCount:(NSInteger)count
{
    if (count == 0) return;
    CGFloat labelH = 35;
    CGFloat labelW = self.view.width;
    CGFloat labelY = navHeight - labelH;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelW, labelH)];
    
    statusLabel.text = [NSString stringWithFormat:@"%ld条新微博",count];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    [self.navigationController.view insertSubview:statusLabel belowSubview:self.navigationController.navigationBar];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        statusLabel.transform = CGAffineTransformMakeTranslation(0, labelY);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            statusLabel.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
        }];
        
    }];
    
}



#pragma mark - 搭建界面
// 设置导航条
- (void)setUpNavBar
{
    UIBarButtonItem *friendsearch = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    self.navigationItem.leftBarButtonItem = friendsearch;
    
    UIBarButtonItem *pop = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = pop;
    
    // 设置titleView
    HJTitleButton *titleButton = [HJTitleButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleButton = titleButton;
    
    self.navigationItem.titleView = titleButton;
    
}

// 点击标题的时候调用
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;

/*    //  显示菜单
    CGFloat x = (self.view.width - 200) * 0.5;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 9;
    
    self.popView.contentView = self.popVc.view;
    
    [self.popView showInRect:CGRectMake(x, y, 200, 200)];
*/
    
}


- (void)friendsearch
{
    
}

- (void)pop
{
    
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    /*
    // 创建cell
    HJStatusCell *cell = [HJStatusCell cellWithTableView:tableView];
    
    HJStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
    
    cell.statusF = statusF;
     */
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //获取模型
    HJStatus *status = self.statusFrameArr[indexPath.row];
    
    //用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HJOneViewController *one = [[HJOneViewController alloc] init];
//    one.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:one animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    HJStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
//    
//    return statusF.cellHeight;
//}


@end
