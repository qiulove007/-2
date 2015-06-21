//
//  HWAccount.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/17.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount
/**
 *  将字典转换为对象
 *
 *  @param dict 字典
 *
 *  @return 字典转换后的对象
 */
+(instancetype)accountWithDict:(NSDictionary*)dict
{
    HWAccount* acc=[[self alloc]init];
    acc.access_token=dict[@"access_token"];
    acc.uid=dict[@"uid"];
    acc.expires_in=dict[@"expires_in"];
    return acc;
}
/**
 *  当一个对象要归档进沙盒的时候，就会调用这个方法
    目的：在这个方法中说明这个对象的那些属性要存进沙盒
 *
 *  @param coder 编码对象
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.created_time forKey:@"created_time"];
}

/**
 *  当一个对象要从沙盒解档的时候（从沙盒中加载一个对象的时候），就会调用这个方法
 目的：在这个方法中说明在这个沙盒中的对象该如何进行解析（需要取出那些属性）
 *
 *  @param coder <#coder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if(self = [super init])
    {
        self.access_token=[coder decodeObjectForKey:@"access_token"];
        self.uid=[coder decodeObjectForKey:@"uid"];
        self.expires_in=[coder decodeObjectForKey:@"expires_in"];
        self.created_time = [coder decodeObjectForKey:@"created_time"];
    }
    return self;
}

@end
