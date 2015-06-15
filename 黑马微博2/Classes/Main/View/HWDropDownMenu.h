//
//  HWDropDownMenu.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/14.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropDownMenu : UIView
+(instancetype) menu;
-(void)showFrom:(UIView*) from;//显示
-(void)disMiss;//销毁或者隐藏

@property (nonatomic,strong)UIView* content;
@end
