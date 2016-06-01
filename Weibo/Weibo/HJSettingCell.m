//
//  HJSettingCell.m
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJSettingCell.h"
#import "HJBaseSetting.h"
#import "HJBadgeView.h"

@interface HJSettingCell ()
//箭头
@property (nonatomic, strong) UIImageView *arrowView;
//开关
@property (nonatomic, strong) UISwitch *switchView;
//打钩
@property (nonatomic, strong) UIImageView *cheakView;
//红圈
@property (nonatomic, strong) HJBadgeView *badgeView;

//label
@property (nonatomic, strong) UILabel *labelView;

@end

@implementation HJSettingCell


- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
        _arrowView = arrowView;
    }
    return _arrowView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        UIImageView *cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        
        _cheakView = cheakView;
    }
    return _cheakView;

}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return  _switchView;
}

- (HJBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [HJBadgeView buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
    }
    return _labelView;
}

+ (instancetype)cellwithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    HJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(HJSettingItem *)item
{
    _item = item;
    
    //设置内容
    [self setUpData];
    
    //设置右边视图
    [self setUpRightView];
    
    //设置label
    if ([_item isKindOfClass:[HJLabelItem class]]) {
        HJLabelItem *labelItem = (HJLabelItem *)_item;
        self.labelView.text = labelItem.text;
        [self addSubview:_labelView];
    }else{
        [_labelView removeFromSuperview];
    }
    
}
//设置内容
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    self.imageView.image = _item.image;
}
//设置右边视图
- (void)setUpRightView
{
    if ([_item isKindOfClass:[HJArrowItem class]]) {//箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[HJBadgeItem class]]) {//badgeView
        HJBadgeItem *badgeItem = (HJBadgeItem *)_item;
        self.badgeView.badgeValue = badgeItem.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([_item isKindOfClass:[HJSwitchItem class]]) {//switchView
        self.accessoryView = self.switchView;
    }else if ([_item isKindOfClass:[HJCheakItem class]]) {//cheakView
        HJCheakItem *cheakItem = (HJCheakItem *)_item;
        if (cheakItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else{
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _labelView.frame = self.bounds;
}

@end
