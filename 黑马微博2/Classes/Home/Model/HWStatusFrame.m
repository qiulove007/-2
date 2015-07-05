//
//  HWStatusFrame.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/29.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWStatusFrame.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWStatusPhotosView.h"

@implementation HWStatusFrame
-(void) setStatus:(HWStatus *)status
{
    _status = status;
    HWUser* user=status.user;
    
    
    //头像
    CGFloat iconWH=50;
    CGFloat iconX=HWStatusCellBorderW;
    CGFloat iconY=HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX,iconY,iconWH,iconWH);
    
    //昵称
    CGFloat nameX=CGRectGetMaxX(self.iconViewF)+HWStatusCellBorderW;
    CGFloat nameY=iconY;
    CGSize nameSize= [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //会员图标
    if(status.user.isVip)
    {
        CGFloat vipX=CGRectGetMaxX(self.nameLabelF)+HWStatusCellBorderW;
        CGFloat vipY=nameY;
        CGSize vipSize=(CGSize){14,nameSize.height};
        self.vipViewF = CGRectMake(vipX, vipY, vipSize.width, vipSize.height);
    }
    
    //发表时间
    CGFloat timeX=nameX;
    CGFloat timeY=CGRectGetMaxY(self.nameLabelF)+HWStatusCellBorderW;
    CGSize timeSize=[self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //来源于
    CGFloat sourceX=CGRectGetMaxX(self.timeLabelF)+HWStatusCellBorderW;
    CGFloat sourceY=timeY;
    CGSize sourceSize=[self sizeWithText:status.source font:HWStatusCellSourceFont];
    self.sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //正文内容
    CGFloat contentX=iconX;
    CGFloat contentY=CGRectGetMaxY(self.iconViewF)+HWStatusCellBorderW;
    CGFloat maxW=[UIScreen mainScreen].bounds.size.width - 2*HWStatusCellBorderW;
    CGSize contentSize=[self sizeWithText:status.text font:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    CGFloat toolbarY=0;//工具条Y
    //微博配图
    CGFloat originalH = 0;
    if(status.pic_urls.count)
    {
        CGSize photoSize=[HWStatusPhotosView photosSizeWithCount:status.pic_urls.count];//图片高度宽度
        CGFloat photoX=contentX;
        CGFloat photoY=CGRectGetMaxY(self.contentLabelF)+HWStatusCellBorderW;
        self.photosViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        
        originalH = CGRectGetMaxY(self.photosViewF)+HWStatusCellBorderW;
        HWLog(@"%d:w.%f h.%f",status.pic_urls.count,photoSize.width,photoSize.height);
    }
    else
    {
        originalH = CGRectGetMaxY(self.contentLabelF)+HWStatusCellBorderW;
        //toolbarY = CGRectGetMaxY(self.contentLabelF)+100;
    }
    
    //原创微博整体
    CGFloat originalX=0;
    CGFloat originalY=0;
    CGFloat originalW=[UIScreen mainScreen].bounds.size.width;
    //CGFloat originalH=CGRectGetMaxY(self.contentLabelF)+50;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    //被转发微博
    if(status.retweeted_status)
    {
        HWStatus* retweeted_status = status.retweeted_status;
        HWUser* retweeted_status_user=retweeted_status.user;
        NSString* content = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        //被转发微博正文
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        CGSize retweetContentSize = [self sizeWithText:content font:HWStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
        
        //被转发微博配图
        CGFloat retweetH=0;
        if(retweeted_status.pic_urls.count)
        {
            CGSize retweeted_photoSize=[HWStatusPhotosView photosSizeWithCount:retweeted_status.pic_urls.count];//图片高度宽度
            CGFloat photoX=retweetContentX;
            CGFloat photoY=CGRectGetMaxY(self.retweetContentLabelF)+HWStatusCellBorderW;
            self.retweetPhotosViewF = CGRectMake(photoX, photoY, retweeted_photoSize.width, retweeted_photoSize.height);
            retweetH=CGRectGetMaxY(self.retweetPhotosViewF)+HWStatusCellBorderW;
            //HWLog(@"re:%d:w.%f h.%f",retweeted_status.pic_urls.count,retweeted_photoSize.width,retweeted_photoSize.height);
        }
        else
        {
            retweetH = CGRectGetMaxY(self.retweetContentLabelF)+HWStatusCellBorderW;
        }
        
        //被转发微博整体
        CGFloat retweetX=0;
        CGFloat retweetY=CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW=[UIScreen mainScreen].bounds.size.width;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    }
    else
    {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    //HWLog(@"toolbar:%f ",)
    
    //工具条
    CGFloat toolbarX=0;
    CGFloat toolbarH=35;
    CGFloat toolbarW=[UIScreen mainScreen].bounds.size.width;
    self.toolbarF = CGRectMake(toolbarX, toolbarY+1, toolbarW, toolbarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF)+HWStatusCellMargin;
}


-(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font maxW:(CGFloat)maxW
{
    NSMutableDictionary* attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    //设置文字显示的范围大小
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    //return [text sizeWithAttributes:attrs];
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font
{
    NSMutableDictionary* attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    return [text sizeWithAttributes:attrs];
}
@end
