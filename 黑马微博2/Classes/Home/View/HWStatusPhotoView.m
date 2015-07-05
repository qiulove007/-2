//
//  HWStatusPhotoView.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/3.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

@interface HWStatusPhotoView()
@property (nonatomic ,weak) UIImageView *gifView;
@end

@implementation HWStatusPhotoView

- (UIImageView *)gifView
{
    if(!_gifView)
    {
        UIImage* gif=[UIImage imageNamed:@"gif"];
        UIImageView* gifView=[[UIImageView alloc] initWithImage:gif];//创建显示gif小字的view
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.contentMode = UIViewContentModeScaleAspectFill;//按照图片原本的宽高比进行伸缩，会超出imageView
        self.clipsToBounds = YES;//超过图片范围的内容裁减掉
    }
    return self;
}

- (void)setPhoto:(HWPhoto *)photo
{
    _photo = photo;
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"zx"]];
    
    //显示/隐藏gif字样
    if([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"])//判断后缀是否是gif
    {
        self.gifView.hidden=NO;
    }
    else
    {
        self.gifView.hidden=YES;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x=self.width-self.gifView.width;
    self.gifView.y=self.height-self.gifView.height;
    
}

@end
