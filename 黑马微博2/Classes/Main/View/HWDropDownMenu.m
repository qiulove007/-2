//
//  HWDropDownMenu.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/14.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWDropDownMenu.h"
@interface HWDropDownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic,weak)UIImageView* containerView;
@end

@implementation HWDropDownMenu

-(UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView* containerView=[[UIImageView alloc]init];
        containerView.image=[UIImage imageNamed:@"listDown"];
        containerView.width=217;
        containerView.height=217;
        containerView.y=40;
        containerView.userInteractionEnabled=YES;//开启用户交互
        
        [self addSubview:containerView];
        self.containerView=containerView;
    }
    return _containerView;
}
-(void) setContent:(UIView *)content
{
    _content=content;
    
    //调整内容的位置
    content.x=10;
    content.y=15;
    
    //设置菜单的尺寸
    self.containerView.height=CGRectGetMaxY(content.frame)+10;
    self.containerView.width=CGRectGetMaxX(content.frame)+10;
    
    [self.containerView addSubview:content];//添加用户需要显示的组件内容
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        
        
        
    }
    return self;
}

+(instancetype)menu
{
    
    return [[self alloc]init];
}

-(void)showFrom:(UIView*) from
{//将自己添加到最上层窗口
    UIWindow* window= [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    //设置尺寸
    self.frame = window.bounds;
    
    //默认情况下，frame时以父控件左上角为坐标原点，可以转换坐标系原点，改变frame的参照点
    CGRect newFrame=[from convertRect:from.bounds toView:window];
    //将from的原本坐标系转换为window的坐标系,返回from在window坐标系的坐标
    
    
    //调整弹窗图片的位置
    self.containerView.centerX=CGRectGetMidX(newFrame);
    self.containerView.y=CGRectGetMaxY(newFrame);
}

-(void)disMiss{
    [self removeFromSuperview];//从窗口中和响应链中移除自己
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self disMiss];//销毁弹出窗口
}


/*
 //添加蒙版，将后面的内容盖起来使其无效化
 UIWindow* window=[[UIApplication sharedApplication].windows lastObject];
 UIView* cover=[[UIView alloc]init];
 cover.backgroundColor=[UIColor clearColor];//设置为透明的颜色
 cover.frame=window.bounds;//得到最上层窗口的大小
 [window addSubview:cover];
 
 UIImageView* dropdownMenu=[[UIImageView alloc]init];
 dropdownMenu.image=[UIImage imageNamed:@"1"];
 dropdownMenu.width=200;
 dropdownMenu.height=100;
 dropdownMenu.y=40;
 
 dropdownMenu.userInteractionEnabled=YES;//开启交互功能，imageView默认是无法与用户进行交互的
 [dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
 
 //[[UIApplication sharedApplication].keyWindow addSubview:dropdownMenu];
 //[UIApplication sharedApplication].keyWindow 得到主要窗口
 [cover addSubview:dropdownMenu];
 //保证某一个view在显示的最上层。
 */
@end
