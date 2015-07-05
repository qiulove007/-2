//
//  HWStatusPhotosView.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/3.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "HWStatusPhotoView.h"

@implementation HWStatusPhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setPhotos:(NSMutableArray *)photos
{
    _photos=photos;
    int photosCount=photos.count;
    
    while(self.subviews.count<photosCount)
    {//创建足够数量的imageView
        HWStatusPhotoView* photoView=[[HWStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    
    //遍历图片控件，设置图片
    for(int i=0;i<self.subviews.count;i++)
    {
        HWStatusPhotoView* photoView=self.subviews[i];
        if(i<photosCount)
        {
            photoView.photo=photos[i];
            photoView.hidden=NO;
            //[photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"zx"]];
        }
        else
        {
            photoView.hidden=YES;
        }
    }
}

-(void)layoutSubviews
{//排布子view
    [super layoutSubviews];//系统自己的排布方式
    
    //等系统弄完了，再来自定义我们自己的排布方式
    //设置图片和位置
    int photosCount=self.photos.count;
    for(int i=0;i<photosCount;i++)
    {
        HWStatusPhotoView* photoView=self.subviews[i];
        
        int col=i%3;
        photoView.x=col*(HWStatusPhotoWH+HWStatusPhotoMargin);
        int row=i/3;
        photoView.y=row*(HWStatusPhotoMargin+HWStatusPhotoWH);
        photoView.width=HWStatusPhotoWH;
        photoView.height=HWStatusPhotoWH;
        
        //photoView.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    
}


+(CGSize)photosSizeWithCount:(int)count
{
    int cols;
    int rows;
    if(count<3)
    {
        if(count==1)
            cols=1;
        else if(count==2)
            cols=2;
        rows=1;
    }
    else
    {
        if(count%3==0)
            rows=count/3;
        else
            rows=count/3+1;
        cols=3;
    }
    
    CGFloat photosW=cols*HWStatusPhotoWH + (cols-1)*HWStatusPhotoMargin;
    
    CGFloat photosH=rows*HWStatusPhotoWH +(rows-1)*HWStatusPhotoMargin;
    
    return (CGSize){photosW,photosH};
}

@end
