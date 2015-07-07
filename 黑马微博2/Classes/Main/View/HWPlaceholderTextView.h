//
//  HWPlaceholderTextView.h
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//  带有占位文字的textView

#import <UIKit/UIKit.h>

@interface HWPlaceholderTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic,copy) NSString* placeHolder;
/**
 *  占位文字的颜色
 */
@property (nonatomic,strong) UIColor* placeHolderColor;
@end
