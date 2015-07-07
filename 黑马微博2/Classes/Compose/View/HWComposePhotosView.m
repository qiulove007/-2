//
//  HWComposePhotosView.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWComposePhotosView.h"

@implementation HWComposePhotosView

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView* photoView=[[UIImageView alloc]init];
    photoView.image=image;
    [self addSubview:photoView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int photosCount=(int)self.subviews.count;
    int maxCol=4;
    CGFloat imageWH=70;
    CGFloat imageMargin=10;
    for(int i=0;i<photosCount;i++)
    {
        UIImageView* photoView=self.subviews[i];
        
        int col=i%maxCol;
        photoView.x=col*(imageWH+imageMargin);
        int row=i/maxCol;
        photoView.y=row*(imageWH+imageMargin);
        photoView.width=imageWH;
        photoView.height=imageWH;
        
        //photoView.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
}

-(NSArray *)Photos
{
    NSMutableArray* photos=[NSMutableArray array];
    for(UIImageView* img in self.subviews)
    {
        [photos addObject:img.image];
    }
    return photos;
}

@end
