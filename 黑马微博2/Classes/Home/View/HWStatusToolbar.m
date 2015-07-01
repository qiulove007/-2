//
//  HWStatusToolbar.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/30.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWStatusToolbar.h"
#import "HWStatus.h"

@interface HWStatusToolbar()
@property (nonatomic,strong) NSMutableArray* dividers;
@property (nonatomic ,strong) NSMutableArray* btns;
//转发
@property (nonatomic ,weak) UIButton* repostBtn;
//评论
@property (nonatomic ,weak) UIButton* commentBtn;
//赞
@property (nonatomic ,weak) UIButton* attitudeBtn;
@end

@implementation HWStatusToolbar

+(instancetype)toolbar
{
    return [[self alloc]init];
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.btns=[NSMutableArray array];
        self.dividers=[NSMutableArray array];
        self.backgroundColor=[UIColor orangeColor];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"vip"];
        self.repostBtn = [self setupBtn:@"转发" icon:@"vip"];
        self.commentBtn =[self setupBtn:@"评论" icon:@"vip"];
        
        
        //HWLog(@"x:%f,y:%f,w:%f,h:%f",self.commentBtn.frame.origin.x,self.commentBtn.frame.origin.y,self.commentBtn.size.width,self.commentBtn.size.height);
        UIView* v1=[self setupDivider];
        UIView* v2=[self setupDivider];
        [self.dividers addObject:v1];
        [self.dividers addObject:v2];
    }
    return self;
}

-(UIButton*) setupBtn:(NSString*)title icon:(NSString*)icon
{
    UIButton* btn=[[UIButton alloc]init];
    //[btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0,5,0,0);
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

-(UIView*)setupDivider
{
    UIView* divi=[[UIView alloc]init];
    divi.backgroundColor = [UIColor grayColor];
    [self addSubview:divi];
    
    [self.dividers addObject:divi];
    return divi;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.btns.count;
    
    CGFloat btnW=self.width/count;
    
    for (int i=0; i<count; i++) {
        UIButton* btn=self.btns[i];
        btn.y=0;
        btn.width = btnW;
        btn.height=self.height;
        btn.x=i*btnW;
        btn.titleLabel.textColor=[UIColor blackColor];
        //HWLog(@"+x:%f,y:%f,w:%f,h:%f",btn.frame.origin.x,btn.frame.origin.y,btn.size.width,btn.size.height);
    }
    int diviCount=(int)self.dividers.count;
    for (int i=0; i<diviCount; i++) {
        UIView* view=self.dividers[i];
        view.width=1;
        view.height=self.height;
        view.x = (i+1)*btnW;
        view.y=0;
    }
}



-(void)setStatus:(HWStatus *)status
{
    _status=status;
    //设置转发
    [self setupBtnTitle:@"转发" count:status.reposts_count btn:self.repostBtn];
    //设置评论
    [self setupBtnTitle:@"评论" count:status.comments_count btn:self.commentBtn];
    //设置赞
    [self setupBtnTitle:@"赞" count:status.attitudes_count btn:self.attitudeBtn];
    
    //HWLog(@"%@",self.repostBtn.titleLabel.text);
}

-(void)setupBtnTitle:(NSString*) defTitle count:(int)count btn:(UIButton*)btn
{
    if(count)
    {
        if(count<10000)
        {
            defTitle=[NSString stringWithFormat:@"%@(%d)",defTitle,count];
            
            //[btn setTitle:defTitle forState:UIControlStateNormal];
            //self.repostBtn.titleLabel.textColor = [UIColor blackColor];
        }
        else
        {
            double countW=count/10000.0;
            defTitle=[NSString stringWithFormat:@"%.1f万",countW];
            
            //[btn setTitle:defTitle forState:UIControlStateNormal];
            
            //将.0万去掉
            defTitle = [defTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    
    [btn setTitle:defTitle forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
