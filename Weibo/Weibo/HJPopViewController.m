//
//  HJPopViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJPopViewController.h"

@interface HJPopViewController ()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation HJPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = @[@"首页",@"好友圈",@"群微博",@"特别关注",@"明星",@"名人明星"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return  cell;
}

@end
