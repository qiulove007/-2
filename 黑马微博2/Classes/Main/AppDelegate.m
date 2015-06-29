//
//  AppDelegate.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "AppDelegate.h"
#import "HWOAuthViewController.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //3.显示窗口
    [self.window makeKeyAndVisible];

    
    HWAccount* account=[HWAccountTool account];
    if(account)
    {//之前成功登陆过
        [self.window switchRootViewController];
    }
    else
    {//没有成功登陆过，所以显示登陆界面
        self.window.rootViewController = [[HWOAuthViewController alloc]init];
    }
    /*
    
    */
     
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager* mgr=[SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    
    //2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  当app进入后台时调用
 *
 *  @param application 代表应用程序
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     *  app的生命周期
     *
     *  1.死亡状态（未运行状态）：没有打开app
     *  2.运行状态：前台运行状态，后台运行状态
     *  3.后台暂停状态：停止一切动画，定时器，多媒体，联网操作等操作
     */
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行程序时间已经过期，就调用该block
        
        //结束任务
        [application endBackgroundTask:task];
    }];
    
    //为了保证程序一直后台运行，除了在info.plist中这只required background modes中设置为多媒体或者音乐播放
    //还需要真的去播放一个音乐文件，可以去播放一个0kb的音乐文件，循环播放
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
