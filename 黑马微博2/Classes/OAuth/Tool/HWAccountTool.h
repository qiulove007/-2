//
//  HWAccountTool.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/19.
//  Copyright (c) 2015年 HM. All rights reserved.
//  处理账号相关的事务操作：存储账号，取出账号

#import <Foundation/Foundation.h>
#import "HWAccount.h"//将整个hwaccount的代码拷贝过来
@class HWAccount;//声明一个类代表它可以使用


@interface HWAccountTool : NSObject
/**
 *  保存账号信息
 *
 *  @param account 账号模型
 */
+(void) saveAccount:(HWAccount*) account;
/**
 *  返回账号信息，如果账号过期则返回nil
 *
 *  @return 账号信息
 */
+(HWAccount*) account;

+(NSString*) getAccess_Token;
+(NSString*) getUid;
@end
