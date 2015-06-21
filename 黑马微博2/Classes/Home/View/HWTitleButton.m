//
//  HWTitleButton.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/21.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWTitleButton.h"

@implementation HWTitleButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        //设置内容居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"listDown"] forState:UIControlStateNormal];
        
        
        //测试代码
        self.backgroundColor = RandomColor;
    }
    return self;
}

/**
 *  设置按钮内部imageView的frame
 *
 *  @param contentRect 按钮的bounds
 *
 *  @return <#return value description#>
 */
//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat x=0;
//    CGFloat y=0;
//    CGFloat width;
//    CGFloat height=contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}
//
///**
// *  设置按钮内部titleLabel的frame
// *
// *  @param contentRect 标题的bounds
// *
// *  @return <#return value description#>
// */
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    CGFloat x=0;
//    CGFloat y=0;
//    CGFloat width;
//    CGFloat height=contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x=self.imageView.x;//原本图在左，标题在右，标题放到图的原本位置
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);//图片放到标题的最高X
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];//改变了标题内容就重新自适应一次
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];//改变了图片内容重新自适应一次
}

@end
