//
//  HJGuideTool.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/25.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJGuideTool.h"

#import "HJNewFeatureController.h"
#import "HJTabBarController.h"

#define HJVersionKey @"version"
#define HJUserDefaults [NSUserDefaults standardUserDefaults]

@implementation HJGuideTool

+(void)guideRootViewController:(UIWindow *)window
{
    
    // 判断是否有新版本
    // 获取之前的版本
    NSString *oldVersion = [HJUserDefaults objectForKey:HJVersionKey];
    // 获取当前版本
    NSString *verKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[verKey];
    
    if (![oldVersion isEqualToString:currentVersion]) { // 有新版本
        // 存储新版本
        [HJUserDefaults setObject:currentVersion forKey:HJVersionKey];
        [HJUserDefaults synchronize];
        
        HJNewFeatureController *newFeatureVc = [[HJNewFeatureController alloc] init];
        window.rootViewController = newFeatureVc;
    }else{
        
        HJTabBarController *tabBarVc = [[HJTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }


}
/*
 //1.获取当前版本号
 NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
 
 //2.获取上一次的版本号
 NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:HJVersionKey];
 
 //判断当前是否有新版本
 if ([currentVersion isEqualToString:lastVersion]) {//没有新版本号
 
 //进入主界面
 HJTabBarController *oauth = [[HJTabBarController alloc] init];
 self.window.rootViewController = oauth;
 
 }else{//有新版本号
 
 //进入新特性界面
 HJNewFeatureController *oauth = [[HJNewFeatureController alloc] init];
 self.window.rootViewController = oauth;
 
 //保持当前版本号
 [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:HJVersionKey];
 }

 */

@end
