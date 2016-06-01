//
//  HJSettingCell.h
//  Weibo
//
//  Created by 傅韩建 on 16/6/1.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJSettingItem;

@interface HJSettingCell : UITableViewCell

+ (instancetype)cellwithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HJSettingItem *item;

@end
