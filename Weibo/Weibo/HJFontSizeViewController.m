//
//  HJFontSizeViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJFontSizeViewController.h"
#import "HJBaseSetting.h"
#import "HJFontSizeTool.h"


@interface HJFontSizeViewController ()

@property (nonatomic, weak) HJCheakItem *selCheakItem;

@end

@implementation HJFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    
}

- (void)setUpGroup0
{
    // 大
    HJCheakItem *big = [HJCheakItem itemWithTitle:@"大"];
    __weak typeof(self) weakSelf = self;
    big.option = ^(HJCheakItem *item){
        [weakSelf selItem:item];
    };
    // 中
    HJCheakItem *middle = [HJCheakItem itemWithTitle:@"中"];
    middle.option = ^(HJCheakItem *item){
        [weakSelf selItem:item];
    };
    // 小
    HJCheakItem *small = [HJCheakItem itemWithTitle:@"小"];
    small.option = ^(HJCheakItem *item){
        [weakSelf selItem:item];
    };

    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self selItemWithTitle:[HJFontSizeTool fontSize]];
}
// 根据字体选中item
- (void)selItemWithTitle:(NSString *)title
{
    
    for (HJGroupItem *group in self.groups) {
        for (HJCheakItem *item in group.items) {
            if ( [item.title isEqualToString:title]) {
                [self selItem:item];
            }
        }
    }
}

- (void)selItem:(HJCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    [self.tableView reloadData];
    
    //保存当前选择的字体
    [HJFontSizeTool saveFontSize:item.title];
    
    //发出通知,修改common里的字体模型
    [[NSNotificationCenter defaultCenter] postNotificationName:HJFontSizeNote object:nil];
    
}


@end
