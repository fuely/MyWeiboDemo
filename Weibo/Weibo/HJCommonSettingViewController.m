//
//  HJCommonSettingViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJCommonSettingViewController.h"
#import "HJBaseSetting.h"
#import "HJFontSizeViewController.h"
#import "HJFontSizeTool.h"

@interface HJCommonSettingViewController ()

@property (nonatomic, weak) HJSettingItem *fontSize;

@end

@implementation HJCommonSettingViewController

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
    // 添加第4组
    [self setUpGroup4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange) name:HJFontSizeNote object:nil];
}

- (void)fontSizeChange
{
    //修改模型
    _fontSize.subTitle = [HJFontSizeTool fontSize];
    
    //刷新界面
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpGroup0
{
    // 阅读模式
    HJSettingItem *read = [HJSettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
    // 字体大小
    HJSettingItem *fontSize = [HJSettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr = [HJFontSizeTool fontSize];
    if (fontSizeStr) {
        fontSize.subTitle = fontSizeStr;
    }else{
        fontSize.subTitle = @"中";
        //存储字体
        [HJFontSizeTool saveFontSize: @"中"];
    }
    fontSize.destVcClass = [HJFontSizeViewController class];
    
    // 显示备注
    HJSwitchItem *remark = [HJSwitchItem itemWithTitle:@"显示备注"];
    
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 图片质量
    HJArrowItem *quality = [HJArrowItem itemWithTitle:@"图片质量" ];
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    HJSwitchItem *sound = [HJSwitchItem itemWithTitle:@"声音" ];
    
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    HJSettingItem *language = [HJSettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 清空图片缓存
    HJArrowItem *clearImage = [HJArrowItem itemWithTitle:@"清空图片缓存"];

    HJGroupItem *group = [[HJGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}


@end
