//
//  HWStatusCell.h
//  黑马微博2
//
//  Created by PC－qiu on 15/6/29.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatusFrame;

@interface HWStatusCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView*) tableView;
@property (nonatomic,strong) HWStatusFrame* statusFrame;
@end
