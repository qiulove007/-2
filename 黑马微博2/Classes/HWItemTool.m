//
//  HWItemTool.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/12.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWItemTool.h"

@implementation HWItemTool

/**
 *  封装barButtonItem,导航按钮
 *
 *  @param action    点击调用的方法
 *  @param image     正常显示图片
 *  @param highImage 高亮显示图片
 *
 *  @return 创建完的ITEM
 */
+(UIBarButtonItem*)itemWithAction:(SEL)action image:(NSString*)image highImage:(NSString*)highImage
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];//创建一个自定义的按钮
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;//如果没有正常显示，请查看有没有设置大小
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
