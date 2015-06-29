//
//  HWLoadMoreFooter.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/24.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter
+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
