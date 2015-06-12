//
//  HWSearchBar.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/12.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.font=[UIFont systemFontOfSize:15];
        self.placeholder = @"请输入内容";//设置灰色提示文字
        [self setBackground:[UIImage imageNamed:@"searchbar1"]];
        
        UIImageView* img=[[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"fd"];
        img.height=30;
        img.width=30;
        img.contentMode = UIViewContentModeCenter;
        self.leftView=img;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype) searchBar
{
    return [[self alloc]init];
}

@end
