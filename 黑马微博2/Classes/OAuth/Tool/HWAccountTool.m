//
//  HWAccountTool.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/19.
//  Copyright (c) 2015年 HM. All rights reserved.
//


#import "HWAccountTool.h"
#import "HWOAuthViewController.h"


@implementation HWAccountTool

//+(void)
+(void)saveAccount:(HWAccount *)account
{
    account.created_time = [NSDate date];
//    //3.写入数据
//    //[responseObject writeToFile:path atomically:YES];
//    //3.写入数据，自定义对象的存储必须使用NSKeyedArchiver来进行，没有writeToFile.
[NSKeyedArchiver archiveRootObject:account toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]];
}

+(HWAccount*) account
{
    HWAccount* acc=[NSKeyedUnarchiver unarchiveObjectWithFile: [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]];
    
    //验证账号是否过期
    long long expires_in=[acc.expires_in longLongValue];//声明周期的秒数
    NSDate* now=[NSDate date];
    
    NSDate* guoqi=[acc.created_time dateByAddingTimeInterval:expires_in];

    if ([now compare:guoqi] != NSOrderedAscending) {
        return nil;
    }
    return acc;
}
@end
