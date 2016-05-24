//
//  UIImage+Resizable.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "UIImage+Resizable.h"

@implementation UIImage (Resizable)

+ (instancetype)resizableWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

@end
