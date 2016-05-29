//
//  HJComposeViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/29.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposeViewController.h"
#import "HJComposeTextView.h"

#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJUser.h"
#import "HJUserTool.h"

@interface HJComposeViewController ()<UITextViewDelegate>

@property (nonatomic, weak) UIButton *composeBtn;

@property (nonatomic, weak) HJComposeTextView *composeTextV;

@end

@implementation HJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNaVBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 监听文本内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:_composeTextV];
}

#pragma  mark - 监听到调用
- (void)textChange
{
    _composeTextV.hidePlaceHolder = _composeTextV.text.length != 0;
    _composeBtn.enabled =  _composeTextV.text.length != 0;
}

#pragma  mark - 设置正文
- (void)setUpTextView
{
    HJComposeTextView *composeTextV = [[HJComposeTextView alloc] initWithFrame:self.view.bounds];
    _composeTextV = composeTextV;
    composeTextV.alwaysBounceVertical = YES;
    composeTextV.delegate = self;
    composeTextV.placeHolder = @"分享新鲜事...";
    
    [self.view addSubview:composeTextV];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_composeTextV becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - 设置导航条
- (void)setUpNaVBar
{
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = cancleItem;
    
    UIButton *composeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [composeBtn setTitle:@"发送" forState:UIControlStateNormal];
    [composeBtn sizeToFit];
    [composeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [composeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [composeBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *composeItem = [[UIBarButtonItem alloc] initWithCustomView:composeBtn];
    composeBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = composeItem;
    _composeBtn = composeBtn;
    
    [self setTitleView];
}

- (void)setTitleView
{
    // 设置titleView
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2, 0, 0, 0)];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    // 获取标题
    NSString *titleName = [HJAccountTool account].name?:@"发微博";
    
    if (titleName == nil) { // 没有标题
        //获取微博昵称
        [HJUserTool userInfoDidsuccess:^(HJUser *user) {
            //设置导航条的标题
            titleLabel.text = user.name;
            //获取当前账号
            HJAccount *account = [HJAccountTool account];
            account.name = user.name;
            //保存用户名称
            [HJAccountTool saveAccount:account];
            
        } failure:^(NSError *error) {
            
        }];
    }else{ // 有标题
        titleLabel.text = titleName;
    }
}

- (void)compose
{
    
//    if (_photosView.images.count) { // 有图片
//        [self composeImage];
//    }else{ // 没有图片
//        [self composeWithoutImage];
//    }
}

- (void)cancle
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
