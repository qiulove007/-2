//
//  HWStatusToolbar.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/30.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus;
@interface HWStatusToolbar : UIView
+(instancetype)toolbar;
@property (nonatomic,strong) HWStatus* status;
@end
