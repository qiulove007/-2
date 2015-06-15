//
//  HWTabBar.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/15.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;//引入HWTabBar类
@protocol HWTabBarDelegate <UITabBarDelegate> //创建代理并遵守之前父类的协议

@optional//可选的
-(void)tabBarDidClickPlusButton:(HWTabBar*)tabBar;//按钮点击

@end

@interface HWTabBar : UITabBar


@property (nonatomic,weak) id<HWTabBarDelegate> delegate;
@end
