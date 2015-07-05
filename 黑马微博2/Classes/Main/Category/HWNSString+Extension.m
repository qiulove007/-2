//
//  HWNSString+Extension.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/2.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWNSString+Extension.h"

@implementation NSString(Extension)
+(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font maxW:(CGFloat)maxW
{
    NSMutableDictionary* attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    //设置文字显示的范围大小
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    //return [text sizeWithAttributes:attrs];
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font
{
    NSMutableDictionary* attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    return [text sizeWithAttributes:attrs];
}
@end
