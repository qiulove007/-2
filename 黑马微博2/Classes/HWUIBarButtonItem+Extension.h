//
//  HWItemTool.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/12.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  用来添加封装ITEM的功能的类
 */
@interface UIBarButtonItem (Extenstion)

+(UIBarButtonItem*)itemWithTarget:(id) target Action:(SEL)action image:(NSString*)image highImage:(NSString*)highImage;

@end
