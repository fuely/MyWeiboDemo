//
//  AppDelegate.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/23.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "AppDelegate.h"

#import "HJOauthViewController.h"
#import "HJGuideTool.h"
#import "HJAccountTool.h"

#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>


@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    if ([HJAccountTool account]) {
        [HJGuideTool guideRootViewController:self.window];
    }else{
        
        HJOauthViewController *oauth = [[HJOauthViewController alloc] init];
        self.window.rootViewController = oauth;
    }

    
    [self.window makeKeyAndVisible];
    
    // 注册提醒通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    //在真机上后台播放,设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //设置会话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活
    [session setActive:YES error:nil];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

//即将失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url  error:nil];
    [player prepareToPlay];
    //无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //开启一个后台任务,时间不确定,优先级比较低,假如系统要关闭应用,首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
