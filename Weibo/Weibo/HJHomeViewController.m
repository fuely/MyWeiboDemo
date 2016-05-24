//
//  HJHomeViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJHomeViewController.h"
#import "HJTitleButton.h"

@interface HJHomeViewController ()

@property (nonatomic, weak) HJTitleButton *titleButton;

@end

@implementation HJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条的内容
    [self setUpNavBar];

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
