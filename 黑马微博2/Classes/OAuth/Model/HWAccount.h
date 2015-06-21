//
//  HWAccount.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/17.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>//
/**
 *  获取授权后的token
 */
@property (nonatomic,copy) NSString* access_token;
/**
 *  声明周期，单位为秒，指的是token可以生存的时间
 */
@property (nonatomic,copy) NSString* expires_in;
/**
 *  用户编号，用于获取一些特殊资料时用得上
 */
@property (nonatomic,copy) NSString* uid;
/**
 *  access token的创建时间
 */
@property (nonatomic,strong) NSDate* created_time;

+(instancetype)accountWithDict:(NSDictionary*)dict;
@end
