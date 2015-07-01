//
//  HWStatusFrame.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/29.
//  Copyright (c) 2015年 HM. All rights reserved.
//  一个HWStatusFrame模型里面包含的信息
//  1.存放一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放一个数据模型HWStatus

#import <Foundation/Foundation.h>
//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
//时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]
//时间字体
#define HWStatusCellSourceFont [UIFont systemFontOfSize:12]
//正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:12]
//转发微博正文字体
#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:12]
#define HWStatusCellMargin 15;//每个cell之间的距离

@class HWStatus;
@interface HWStatusFrame : NSObject
@property (nonatomic,strong) HWStatus* status;
@property (nonatomic ,assign) CGRect originalViewF;//原创微博整体
@property (nonatomic ,assign) CGRect iconViewF;//头像
@property (nonatomic ,assign) CGRect vipViewF;//会员图标
@property (nonatomic ,assign) CGRect photoViewF;//微博配图
@property (nonatomic ,assign) CGRect nameLabelF;//昵称
@property (nonatomic ,assign) CGRect timeLabelF;//发表时间
@property (nonatomic ,assign) CGRect sourceLabelF;//来源于
@property (nonatomic ,assign) CGRect contentLabelF;//正文内容

/*转发微博*/
@property (nonatomic,assign) CGRect retweetViewF;//转发微博整体
@property (nonatomic,assign) CGRect retweetContentLabelF;//转发正文+昵称
@property (nonatomic,assign) CGRect retweetPhotoViewF;//转发配图

//底部工具条
@property (nonatomic,assign) CGRect toolbarF;//底部工具条

@property (nonatomic ,assign) CGFloat cellHeight;//cell高度
@end
