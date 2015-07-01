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
/**
 *  创建时间
 */
@property (nonatomic,copy) NSString* created_at;
/**
 *  来源于
 */
@property (nonatomic,copy) NSString* source;
/**
 *  微博配图地址，
 */
@property (nonatomic,strong) NSArray* pic_urls;
/**
 *  转发数
 */
@property (nonatomic,assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic,assign) int comments_count;
/**
 *  表态数
 */
@property (nonatomic,assign) int attitudes_count;
/**
 *  被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic,strong) HWStatus* retweeted_status;

+(instancetype)statusWithDict:(NSDictionary*)dict;
@end
