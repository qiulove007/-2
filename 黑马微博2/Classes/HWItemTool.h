//
//  HWItemTool.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/12.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用来添加封装ITEM的功能的类
 */
@interface HWItemTool : NSObject

+(UIBarButtonItem*)itemWithAction:(SEL)action image:(NSString*)image highImage:(NSString*)highImage;

@end
