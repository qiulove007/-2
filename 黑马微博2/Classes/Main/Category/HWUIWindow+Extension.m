//
//  HWUIWindow+Extension.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/20.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWUIWindow+Extension.h"
#import "HWTabBarViewController.h"
#import "HWNewFeatrueViewController.h"

@implementation UIWindow(Extension)
-(void)switchRootViewController
{
    UIWindow* window=[UIApplication sharedApplication].keyWindow;
    //是否显示新特性需要取得上一次的使用版本（沙盒中的版本）,
    NSString* key=@"CFBundleVersion";
    NSString* lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //和当前的软件的版本号（从info.plist中获得）
    NSString* version=[NSBundle mainBundle].infoDictionary[key];
    
    if([lastVersion isEqualToString:version])
    {//版本号相同的情况
        //2.设置根控制器
        window.rootViewController = [[HWTabBarViewController alloc]init];
    }
    else
    {
        window.rootViewController = [[HWNewFeatrueViewController alloc]init];
        
        //将版本号存储进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//直接存储
    }
}
@end
