//
//  HWTabBar.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/15.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWTabBar.h"

@interface HWTabBar()
@property(nonatomic,weak)UIButton* addBtn;
@end

@implementation HWTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        //添加一个发微博的按钮到tabbar中
        UIButton* addBtn=[[UIButton alloc]init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"d_chijing"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"d_nu"] forState:UIControlStateHighlighted];
        addBtn.size=addBtn.currentBackgroundImage.size;
//        addBtn.centerX=self.width*0.5;
//        addBtn.centerY=self.height*0.5;
        [self addSubview:addBtn];
        self.addBtn=addBtn;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置发微博按钮的位置
    self.addBtn.centerX = self.width*0.5;
    self.addBtn.centerY=self.height*0.5;
    
    //设置其他tabbarButton的位置和尺寸
    CGFloat tabbarWidth=self.width/5;//拜访5个项目，每个项目的宽度
    CGFloat tabbarX=0;//设置初始位置
    int count=self.subviews.count;
    for (int i=0; i<count; i++) {
        UIView* child=self.subviews[i];
        Class class=NSClassFromString(@"UITabBarButton");
        //UITabBarButton只可供IOS内部使用，所以使用这种方式去取得
        if([child isKindOfClass:class])
        {
            child.width = tabbarWidth;//设置UItabbarButton的宽度
            child.x=tabbarX*tabbarWidth;//设置x
            
            tabbarX++;//增加一个项目宽度的位置
            if(tabbarX==2)
                tabbarX++;
        }
    }
}

@end
