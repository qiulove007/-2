//
//  HWNSString+Extension.h
//  黑马微博2
//
//  Created by PC－qiu on 15/7/2.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Extension)
+(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font maxW:(CGFloat)maxW;
+(CGSize) sizeWithText:(NSString*)text font:(UIFont*)font;
@end
