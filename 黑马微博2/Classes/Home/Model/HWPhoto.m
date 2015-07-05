//
//  HWPhoto.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/30.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWPhoto.h"

@implementation HWPhoto
+(instancetype)photoWithDict:(NSDictionary*)dict
{
    HWPhoto* photo=[[self alloc]init];
    photo.thumbnail_pic = dict[@"thumbnail_pic"];
    return photo;
}
@end
