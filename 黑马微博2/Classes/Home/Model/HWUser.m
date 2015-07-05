//
//  HWUser.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/22.
//  Copyright (c) 2015年 HM. All rights reserved.
//  用户模型，保存关注的用户的相关信息

#import "HWUser.h"

@implementation HWUser
+(instancetype)userWithDict:(NSDictionary*)dict
{
    HWUser* user=[[self alloc]init];
    user.idstr = dict[@"idstr"];
    user.profile_name_url = dict[@"profile_image_url"];
    user.name = dict[@"name"];
    user.mbtype=(int)dict[@"mbtype"];
    user.mbrank=(int)dict[@"mbrank"];
    
    user.verified_type = (int)dict[@"verified_type"];
    return user;
}
-(void)setMbtype:(int)mbtype
{
    _mbtype=mbtype;
    self.vip=mbtype>2;
}
//-(BOOL)isVip
//{
//    if(self.mbtype>2)
//        return YES;
//    else
//        return NO;
//}
@end
