//
//  HWIconView.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/3.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView()
@property (nonatomic,weak) UIImageView* verifiedView;
@end

@implementation HWIconView
- (UIImageView *)verifiedView
{
    if(!_verifiedView)
    {
        UIImageView* verifiedView=[[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView=verifiedView;
    }
    return _verifiedView;
}
-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}
-(void)setUser:(HWUser *)user
{
    _user=user;
    //1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_name_url] placeholderImage:[UIImage imageNamed:@"zx"]];
    //2.认证图片
    switch (user.verified_type) {
        case HWUserVerifiedTypeNone://没有认证
            self.verifiedView.hidden=YES;
            break;
        case HWUserVerifiedTypeOrgEnterprice://
        case HWUserVerifiedTypeOrgMedia://
        case HWUserVerifiedTypeOrgWebsite://各种企业认证
            self.verifiedView.hidden=NO;
            self.verifiedView.image = [UIImage imageNamed:@"guanV"];
            break;
        case HWUserVerifiedTypeDaren://达人认证
            self.verifiedView.hidden=NO;
            self.verifiedView.image = [UIImage imageNamed:@"darenV"];
            break;
        case HWUserVerifiedTypePersonal://个人认证
            self.verifiedView.hidden=NO;
            self.verifiedView.image = [UIImage imageNamed:@"geV"];
            break;
            
        default:
            //当做没有认证
            self.verifiedView.hidden=YES;

            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size=self.verifiedView.image.size;
    self.verifiedView.x=self.width-self.verifiedView.width*0.65;
    self.verifiedView.y=self.height-self.verifiedView.height*0.65;
    
}

@end
