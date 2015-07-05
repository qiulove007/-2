//
//  HWPhoto.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/30.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPhoto : NSObject
/**
 *  缩略图
 */
@property (nonatomic,copy) NSString* thumbnail_pic;

+(instancetype)photoWithDict:(NSDictionary*)dict;
@end
