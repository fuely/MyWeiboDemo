//
//  HJComposeViewController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/29.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJComposeViewController.h"
#import "HJComposeTextView.h"
#import "HJComposeToolBar.h"
#import "HJComposePhotosView.h"

#import "HJAccount.h"
#import "HJAccountTool.h"
#import "HJUser.h"
#import "HJUserTool.h"
#import "HJComposeTool.h"

#import "MBProgressHUD+MJ.h"

@interface HJComposeViewController ()<UITextViewDelegate,HJComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIButton *composeBtn;

@property (nonatomic, weak) HJComposeTextView *composeTextV;

@property (nonatomic, weak) HJComposeToolBar *toolBar;

@property (nonatomic, weak) HJComposePhotosView *photosView;

@end

@implementation HJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNaVBar];
    
    // 添加textView
    [self setUpTextView];
    
    //添加工具条
    [self setUpToolBar];
    
    // 监听键盘改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //添加相册视图
    [self setUpPhotosView];
}

- (void)setUpPhotosView
{
    HJComposePhotosView *photosView = [[HJComposePhotosView alloc] initWithFrame:_composeTextV.bounds];
    photosView.y = 70;
    _photosView = photosView;
    [_composeTextV addSubview:photosView];
}

#pragma mark - 键盘Frame改变时候diaoy

- (void)KeyboardFrameChange:(NSNotification *)note
{
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //获取键盘的Frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (keyboardFrame.origin.y == self.view.height) {//没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{//弹出键盘
        //工具往上移动258
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        }];
    }
}


#pragma mark - 设置工具条
- (void)setUpToolBar
{
    CGFloat h =35;
    CGFloat y = self.view.height - h;
    HJComposeToolBar *toolBar = [[HJComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    _toolBar.delegate = self;
    [self.view addSubview:toolBar];
   
}

#pragma  mark - HJComposeToolBarDelegate

- (void)composeToolBar:(HJComposeToolBar *)toolBar didClickBtn:(HJComposeToolBarButtonType)type
{
    switch (type) {
        case HJComposeToolBarButtonTypeCamera:
        {
            //进入相册
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
            break;
        case HJComposeToolBarButtonTypeMention:
            break;
        case HJComposeToolBarButtonTypeTrend:
            break;
        case HJComposeToolBarButtonTypeEmoticon:
            break;
        case HJComposeToolBarButtonTypeKeyboard:
            break;
        default:
            break;
    }
}

#pragma mark - 选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    _photosView.image = image;
    
    _composeBtn.enabled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置正文
- (void)setUpTextView
{
    HJComposeTextView *composeTextV = [[HJComposeTextView alloc] initWithFrame:self.view.bounds];
    _composeTextV = composeTextV;
    composeTextV.alwaysBounceVertical = YES;
    composeTextV.delegate = self;
    composeTextV.placeHolder = @"分享新鲜事...";
    
    [self.view addSubview:composeTextV];
    
    // 监听文本内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:_composeTextV];
    
}

#pragma mark - UITextViewDelegate 拖拽时候调用
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

#pragma mark - 监听到调用
- (void)textChange
{
    _composeTextV.hidePlaceHolder = _composeTextV.text.length != 0;
    _composeBtn.enabled =  _composeTextV.text.length != 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 设置导航条
- (void)setUpNaVBar
{
    self.title = @"发微博";
    
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
}

- (void)compose
{
    
    if (_photosView.images.count) { // 有图片
        [self sentPicture];
    }else{ // 没有图片
        [self sentText];
    }
}

//发送图片
- (void)sentPicture
{
    [MBProgressHUD showMessage:@"正在发送。。。"];
    UIImage *image = [_photosView.images firstObject];
    NSString *status = _composeTextV.text.length?_composeTextV.text:@"分享图片";
    
    [HJComposeTool composeWithImage:image status:status success:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",error.description);
    }];
    
}

//发送文字
- (void)sentText
{
    [HJComposeTool composeWithSatausText:_composeTextV.text success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];
}


- (void)cancle
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
