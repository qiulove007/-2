//
//  HWComposeToolbar.h
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    HWComposeToolbarButtonTypeCamera,//拍照
    HWComposeToolbarButtonTypePicture,//相册
    HWComposeToolbarButtonTypeMention,//@
    HWComposeToolbarButtonTypeTrend,//#
    HWComposeToolbarButtonTypeEmotion//表情
}HWComposeToolbarButtonType;

@class HWComposeToolbar;
@protocol HWComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(HWComposeToolbar*)toolbar didClickButton:(HWComposeToolbarButtonType)type;
@end

@interface HWComposeToolbar : UIView
@property(nonatomic,weak) id<HWComposeToolbarDelegate> delegate;
@end
