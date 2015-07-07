//
//  HWPlaceholderTextView.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWPlaceholderTextView.h"

@implementation HWPlaceholderTextView

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        //通知，可以设置多次，
        //当UITextView的文字发生改变的时候，UITextView自己会发出一个UITextViewTextDidChangeNotification的通知
        //参数1：添加给谁
        //参数2：通知后要执行的方法
        //参数3：发出什么样的通知
        //参数4：谁发出通知。
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        self.placeHolderColor=[UIColor grayColor];
    }
    return self;
}
/**
 *  监听文字改变
 */
-(void)textDidChange
{
    [self setNeedsDisplay];//重绘（重新调用drawRect方法）
}

-(void)drawRect:(CGRect)rect
{
    if(self.hasText) return;
    
    //设置文字属性
    NSMutableDictionary* attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHolderColor;
    //绘画文字
    //[self.placeHolder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGRect placeHolderRect=CGRectMake(5, 8, rect.size.width-10, rect.size.height-16);
    [self.placeHolder drawInRect:placeHolderRect withAttributes:attrs];
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder=[placeHolder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor=placeHolderColor;
    [self setNeedsDisplay];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
