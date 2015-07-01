//
//  HWUser.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/22.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUser : NSObject
/**
 *  字符串型UID
 */
@property (nonatomic,copy) NSString* idstr;
/**
 *  用户名
 */
@property (nonatomic,copy) NSString* name;
/**
 *  用户头像缩略图地址
 */
@property (nonatomic,copy) NSString* profile_name_url;

/**
 *  会员类型，当type大于2的时候是会员
 */
@property (nonatomic,assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic,assign) int mbrank;
/**
 *  获得是否是vip
 */
@property (nonatomic,assign,getter=isVip) BOOL vip;

+(instancetype)userWithDict:(NSDictionary*)dict;
@end
