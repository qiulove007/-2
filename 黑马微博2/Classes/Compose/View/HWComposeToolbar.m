//
//  HWComposeToolbar.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWComposeToolbar.h"

@interface HWComposeToolbar()
//@property(nonatomic,weak) UIButton*
@end

@implementation HWComposeToolbar

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor grayColor];
        [self setupBtnWithTitle:@"拍照" type:HWComposeToolbarButtonTypeCamera];
        [self setupBtnWithTitle:@"相册" type:HWComposeToolbarButtonTypePicture];
        [self setupBtnWithTitle:@"@" type:HWComposeToolbarButtonTypeMention];
        [self setupBtnWithTitle:@"#" type:HWComposeToolbarButtonTypeTrend];
        [self setupBtnWithTitle:@"表情" type:HWComposeToolbarButtonTypeEmotion];
    }
    return self;
}

-(UIButton* )setupBtn:(NSString*)image highImage:(NSString*)highImage
{
    UIButton* btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}
-(UIButton*)setupBtnWithTitle:(NSString*)title type:(HWComposeToolbarButtonType) type
{
    UIButton* btn=[[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.enabled=YES;
    btn.tag=type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //btn.titleLabel.textColor=[UIColor blackColor];
    [self addSubview:btn];
    return btn;
}

/**
 *  重写子控件排布方法
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count=self.subviews.count;
    CGFloat btnW=self.width/count;
    CGFloat btnH=self.height;
    for (int i=0; i<count; i++) {
        UIButton* btn=self.subviews[i];
        btn.y=0;
        btn.x=btnW*i;
        btn.width=btnW;
        btn.height=btnH;
    }
}

-(void)btnClick:(UIButton*)button
{
    if([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)])
    {
        [self.delegate composeToolbar:self didClickButton:(HWComposeToolbarButtonType)button.tag];
    }
}

@end
