//
//  AppDelegate.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "AppDelegate.h"
#import "HWTabBarViewController.h"
#import "HWNewFeatrueViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    

    
    //是否显示新特性需要取得上一次的使用版本（沙盒中的版本）,
    NSString* key=@"CFBundleVersion";
    NSString* lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //和当前的软件的版本号（从info.plist中获得）
    NSDictionary* info=[NSBundle mainBundle].infoDictionary;
    NSString* version=info[key];
    
    
    
    if([lastVersion isEqualToString:version])
    {//版本号相同的情况
        //2.设置根控制器
        HWTabBarViewController* tabbar=[[HWTabBarViewController alloc]init];
        self.window.rootViewController = tabbar;
    }
    else
    {
        self.window.rootViewController = [[HWNewFeatrueViewController alloc]init];
        
        //将版本号存储进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];//直接存储
    }
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
