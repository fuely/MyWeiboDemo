//
//  HJSearchBar.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJSearchBar.h"

@implementation HJSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.placeholder = @"大家都在搜索:韩小哥就是我";
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage resizableWithImageName:@"searchbar_textfield_background"];
        
        //设置左边的View
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
