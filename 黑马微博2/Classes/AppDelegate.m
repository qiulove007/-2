//
//  AppDelegate.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "AppDelegate.h"
#import "PrefixHeader.pch"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    
    //2.设置根控制器
    UITabBarController* tabbar=[[UITabBarController alloc]init];
    self.window.rootViewController = tabbar;
    
    //3.设置子控制器
    UIViewController* vc1=[[UIViewController alloc]init];
    vc1.tabBarItem.title=@"首页";
    vc1.tabBarItem.image = [[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.view.backgroundColor = RandomColor;
    //设置未选中文字的样式
    NSMutableDictionary* textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //设置选中文字的样式
    NSMutableDictionary* seltextAttrs=[NSMutableDictionary dictionary];
    seltextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc1.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
    
    
    UIViewController* vc2=[[UIViewController alloc]init];
    vc2.tabBarItem.title=@"消息";
    vc2.tabBarItem.image = [[UIImage imageNamed:@"2.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"6.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.view.backgroundColor = RandomColor;
    [vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
    
    UIViewController* vc3=[[UIViewController alloc]init];
    vc3.tabBarItem.title=@"发现";
    vc3.tabBarItem.image = [[UIImage imageNamed:@"3.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"1.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.view.backgroundColor = RandomColor;
    [vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
    
    UIViewController* vc4=[[UIViewController alloc]init];
    vc4.tabBarItem.title=@"我";
    vc4.tabBarItem.image = [[UIImage imageNamed:@"4.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"2.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc4.view.backgroundColor = RandomColor;
    [vc4.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
    //注意：如果直接给一张图片会被渲染成默认的颜色，所以要设置为不要被渲染的模式
    //即imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
    
    
    //4.添加子控制器
    tabbar.viewControllers =@[vc1,vc2,vc3,vc4];
    
    
    
    
    
    //5.显示窗口
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
