//
//  HWStatusCell.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/29.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "HWPhoto.h"
#import "HWStatusToolbar.h"
@interface HWStatusCell()

@property (nonatomic ,weak) UIView* originalView;//原创微博整体
@property (nonatomic ,weak) UIImageView* iconView;//头像
@property (nonatomic ,weak) UIImageView* vipView;//会员图标
@property (nonatomic ,weak) UIImageView* photoView;//微博配图
@property (nonatomic ,weak) UILabel* nameLabel;//昵称
@property (nonatomic ,weak) UILabel* timeLabel;//发表时间
@property (nonatomic ,weak) UILabel* sourceLabel;//来源于
@property (nonatomic ,weak) UILabel* contentLabel;//正文内容

/*转发微博*/
@property (nonatomic ,weak) UIView* retweetView;//转发微博整体
@property (nonatomic ,weak) UILabel* retweetContentLabel;//转发微博正文+昵称
@property (nonatomic ,weak) UIImageView* retweetPhotoView;//转发配图

/*工具条*/
@property (nonatomic ,weak) HWStatusToolbar* toolbar;
@end

@implementation HWStatusCell

-(void)setStatusFrame:(HWStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    HWStatus* status=statusFrame.status;
    HWUser* user=statusFrame.status.user;
    
    //!!!设置所有子控件的frame和数据
    self.originalView.frame = statusFrame.originalViewF;
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_name_url] placeholderImage:[UIImage imageNamed:@"zx"]];
    
    self.vipView.frame = statusFrame.vipViewF;
    if(user.isVip)
    {
        self.vipView.hidden=NO;
        self.vipView.image = [UIImage imageNamed:@"vip"];
        self.nameLabel.textColor=[UIColor orangeColor];
    }
    else
    {
        self.vipView.hidden=YES;
        self.nameLabel.textColor=[UIColor blackColor];
    }
    
    if(status.pic_urls.count)
    {
        self.photoView.frame = statusFrame.photoViewF;
        //        HWPhoto* photo=[status.pic_urls firstObject];
        //        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"zx"]];
        self.photoView.backgroundColor = [UIColor blackColor];
        self.photoView.hidden=NO;
    }
    else
    {
        self.photoView.hidden=YES;
    }
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text=status.created_at;
    
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text=status.source;
    
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    /*被转发的微博*/
    if(status.retweeted_status)
    {
        HWStatus* retweeted_status = status.retweeted_status;
        HWUser* retweeted_status_user=retweeted_status.user;
        
        self.retweetView.hidden=NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        //被转发微博正文
        self.retweetContentLabel.text=[NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        //被转发的微博配图
        if(retweeted_status.pic_urls.count)
        {
            self.retweetPhotoView .frame = statusFrame.retweetPhotoViewF;
            //        HWPhoto* photo=[retweeted_status.pic_urls firstObject];
            //        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"zx"]];
            self.retweetPhotoView.backgroundColor = [UIColor blackColor];
            self.retweetPhotoView.hidden=NO;
        }
        else
        {
            self.retweetPhotoView.hidden=YES;
        }
    }
    else
    {
        self.retweetView.hidden=YES;
    }
    
    //工具条
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status=status;
}

+(instancetype)cellWithTableView:(UITableView *) tableView
{
    static NSString* ID=@"";
    HWStatusCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次，一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];//设置背景为透明色
        //设置点击以后不会变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置选中时的背景
//        UIView* bg=[[UIView alloc]init];
//        bg.backgroundColor=[UIColor blueColor];
//        self.selectedBackgroundView = bg;
        
        //添加整体视图
        UIView* ori=[[UIView alloc]init];
        ori.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:ori];
        self.originalView=ori;
        
        UIImageView* iconView=[[UIImageView alloc]init];
        [self.originalView addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView* vipView=[[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self.originalView addSubview:vipView];
        self.vipView = vipView;
        
        UIImageView* photoView=[[UIImageView alloc]init];
        [self.originalView addSubview:photoView];
        self.photoView = photoView;
        
        UILabel* nameLabel=[[UILabel alloc]init];
        nameLabel.font = HWStatusCellNameFont;
        [self.originalView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel* timeLabel=[[UILabel alloc]init];
        timeLabel.font=HWStatusCellTimeFont;
        [self.originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel* sourceLabel=[[UILabel alloc]init];
        sourceLabel.font=HWStatusCellSourceFont;
        [self.originalView addSubview:sourceLabel];
        self.sourceLabel =sourceLabel;
        
        UILabel* contentLabel=[[UILabel alloc]init];
        [contentLabel setNumberOfLines:0];//设置正文内容自动换行
        contentLabel.font=HWStatusCellContentFont;
        [self.originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView* retweetView = [[UIView alloc]init];
        retweetView.backgroundColor=myColor(247, 247, 247);
        [self.contentView addSubview:retweetView];
        self.retweetView=retweetView;
        
        UILabel* retweetContentLabel=[[UILabel alloc]init];
        [retweetContentLabel setNumberOfLines:0];
        retweetContentLabel.font=HWStatusCellRetweetContentFont;
        [self.retweetView addSubview:retweetContentLabel];
        self.retweetContentLabel=retweetContentLabel;
        
        UIImageView* retweetPhotoView=[[UIImageView alloc]init];
        [self.retweetView addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
        
        HWStatusToolbar* toolbar=[HWStatusToolbar toolbar];
        //toolbar.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:toolbar];
        self.toolbar=toolbar;
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
