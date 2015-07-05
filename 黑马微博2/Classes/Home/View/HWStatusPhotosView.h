//
//  HWStatusPhotosView.h
//  黑马微博2
//
//  Created by PC－qiu on 15/7/3.
//  Copyright (c) 2015年 HM. All rights reserved.
//  cell上面的配图相册（可能会显示1~9张图片）

#import <UIKit/UIKit.h>
#define HWStatusPhotoWH 70 //图片宽高
#define HWStatusPhotoMargin 7 //图片间距

@interface HWStatusPhotosView : UIView
@property (nonatomic,strong) NSMutableArray* photos;

/**
 *  根据图片个数计算整个View的尺寸
 *
 *  @param count 图片个数
 *
 *  @return HWStatusPhotosView的尺寸
 */
+(CGSize)photosSizeWithCount:(int)count;
@end
