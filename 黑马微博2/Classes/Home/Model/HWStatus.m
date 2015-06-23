//
//  HWStatus.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/22.
//  Copyright (c) 2015年 HM. All rights reserved.
//  微博模型，保存用户信息字典，保存了多个HWUser的信息

#import "HWStatus.h"
#import "HWUser.h"

@implementation HWStatus
+(instancetype)statusWithDict:(NSDictionary*)dict
{
    HWStatus* status=[[self alloc]init];
    status.idstr=dict[@"idstr"];
    status.user=[HWUser userWithDict:dict[@"user"]];
    status.text=dict[@"text"];
    return status;
}
@end
