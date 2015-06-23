//
//  HWStatus.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/22.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWUser;

@interface HWStatus : NSObject
/**
 *  字符串型UID
 */
@property (nonatomic,copy) NSString* idstr;
/**
 *  微博文本信息，正文内容
 */
@property (nonatomic,copy) NSString* text;
/**
 *  发微博者用户信息字典对应之模型
 */
@property (nonatomic,strong) HWUser* user;

+(instancetype)statusWithDict:(NSDictionary*)dict;
@end
