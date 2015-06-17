//
//  HWNewFeatrueViewController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/15.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWNewFeatrueViewController.h"
#import "HWTabBarViewController.h"
#define HWNewfeatureCount 5 //声明一个宏保存新特性图片的个数

@interface HWNewFeatrueViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl* page;
@end

@implementation HWNewFeatrueViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个scrollView显示所有的新特性图片
    UIScrollView* scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;//占满整个屏幕
    [self.view addSubview:scrollView];
    
    CGFloat scrollW=scrollView.width;
    CGFloat scrollH=scrollView.height;
    //添加图片到scrollview中
    for(int i=0;i<HWNewfeatureCount;i++)
    {
        UIImageView* imageView=[[UIImageView alloc]init];
        imageView.width=scrollW;
        imageView.height=scrollH;
        imageView.y=0;
        imageView.x=i*scrollW;
        NSString* path=[NSString stringWithFormat:@"ai%d",i+1];
        imageView.image=[UIImage imageNamed:path];
        [scrollView addSubview:imageView];
        
        //如果是最后一个imageView,加入开始按钮
        if(i==HWNewfeatureCount-1)
        {
            [self setupLastImageView:imageView];
        }
    }
    
    //contentSize设置scrollView可以进行拖动的范围
    scrollView.contentSize=CGSizeMake(HWNewfeatureCount*scrollW, 0);
    scrollView.bounces=NO;//取出弹簧效果，不过看到超出部分的内容
    scrollView.pagingEnabled=YES;//进行拖动的时候自动分页
    scrollView.delegate=self;
    
    //添加PageControl进行分页
    UIPageControl* page=[[UIPageControl alloc]init];
    page.numberOfPages=HWNewfeatureCount;
    page.width=100;
    page.height=50;
    page.centerX=scrollW*0.5;
    page.centerY=scrollH-50;
    page.currentPageIndicatorTintColor=[UIColor orangeColor];//当前正在访问的圆点的颜色
    page.pageIndicatorTintColor = [UIColor grayColor];//设置未显示的page的圆点颜色
    page.userInteractionEnabled=NO;//禁止通过圆点的点击来访问对应页面
    self.page=page;
    
    [self.view addSubview:page];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollView的contentOffset可以得到滚动的位置信息，x,y值
    self.page.currentPage=round((scrollView.contentOffset.x / scrollView.width));
}

-(void)setupLastImageView:(UIImageView*)imageView
{
    //开启用户交互
    imageView.userInteractionEnabled=YES;
    //1.checkbox
    UIButton* share=[[UIButton alloc]init];
    [share setImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"1"] forState:UIControlStateHighlighted];
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:15];
    share.width=100;
    share.height=30;
    share.centerX = imageView.width*0.5;
    share.centerY=imageView.height*0.68;
    [share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:share];
    
    //开始微博
    UIButton* startBtn=[[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    startBtn.size = CGSizeMake(120  ,60);
    startBtn.centerX=imageView.width*0.5;
    startBtn.centerY=imageView.height*0.75;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    //[startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    
    [imageView addSubview:startBtn];
    
}

-(void)shareClick:(id)sender
{
    //UIView* myview=[self.view superview];//.window.rootViewController
    
}
-(void)startClick
{
    //切换到tabbarController
    /**
     切换控制器的方法：1.push。2.modal。3.切换window的rootViewController
     */
    UIWindow* window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[HWTabBarViewController alloc]init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
