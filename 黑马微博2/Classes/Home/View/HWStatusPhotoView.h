//
//  HWStatusPhotoView.h
//  黑马微博2
//
//  Created by PC－qiu on 15/7/3.
//  Copyright (c) 2015年 HM. All rights reserved.
//  cell上面的配图相册，全部使用HWStatusPhotoView 来做图片显示

#import <UIKit/UIKit.h>
@class HWPhoto;

@interface HWStatusPhotoView : UIImageView
@property (nonatomic,strong) HWPhoto* photo;
@end
