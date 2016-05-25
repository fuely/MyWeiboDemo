//
//  HJStatusCell.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJStatusCell.h"

#import "HJOriginalView.h"
#import "HJRetweetedView.h"
#import "HJToolBarView.h"

#import "HJStatus.h"
#import "HJStatusFrame.h"

@interface HJStatusCell()

@property (nonatomic, weak) HJOriginalView *originalView;
@property (nonatomic, weak) HJRetweetedView *retweetedView;
@property (nonatomic, weak) HJToolBarView *toolBar;

@end

@implementation HJStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setUpAllSubviews
{
    // 添加原创微博
    HJOriginalView *originalView = [[HJOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    _originalView = originalView;
    
    // 添加转发微博
    HJRetweetedView *retweetedView = [[HJRetweetedView alloc] init];
    [self.contentView addSubview:retweetedView];
    _retweetedView = retweetedView;
    
    // 添加工具条
    HJToolBarView *toolBar = [[HJToolBarView alloc] init];
    
    [self.contentView addSubview:toolBar];
    _toolBar = toolBar;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    HJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusF:(HJStatusFrame *)statusF
{
    _statusF = statusF;
    
    HJStatus *status = statusF.status;
    
    // 设置原创微博
    _originalView.statusF = statusF;
    
    if (status.retweeted_status) {
        
        // 设置转发微博
        _retweetedView.statusF = statusF;
        _retweetedView.hidden = NO;
    }else{
        _retweetedView.hidden = YES;
    }
    
    // 设置工具条的位置
    _toolBar.status = status;
    _toolBar.frame = statusF.toolBarViewF;
    
    
}

@end
