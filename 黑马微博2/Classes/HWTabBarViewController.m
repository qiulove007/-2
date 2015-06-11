//
//  HWTabBarViewController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWNavigationController.h"

@interface HWTabBarViewController ()

@end

@implementation HWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    HWHomeViewController* home=[[HWHomeViewController alloc]init];
    
    [self addChildVC:home title:@"首页" image:@"1" selectedImage:@"5"];
    
    HWMessageCenterViewController* msg=[[HWMessageCenterViewController alloc]init];
    [self addChildVC:msg title:@"消息" image:@"2" selectedImage:@"6"];
    
    HWDiscoverViewController* discover=[[HWDiscoverViewController alloc]init];
    [self addChildVC:discover title:@"发现" image:@"3" selectedImage:@"1"];
    
    HWProfileViewController* profile=[[HWProfileViewController alloc]init];
    [self addChildVC:profile title:@"我" image:@"4" selectedImage:@"2"];
    
    //4.添加子控制器
    //self.viewControllers =@[home,msg,discover,profile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildVC:(UIViewController*)childVc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    childVc.navigationItem.title=title;//设置导航标题与下标题一致
    childVc.tabBarItem.title=title;
    //childVc.title=title;//这一句可以完成上面两句代码的作用
    
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.view.backgroundColor = RandomColor;
    //设置未选中文字的样式
    NSMutableDictionary* textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //设置选中文字的样式
    NSMutableDictionary* seltextAttrs=[NSMutableDictionary dictionary];
    seltextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
    
    //注意：如果直接给一张图片会被渲染成默认的颜色，所以要设置为不要被渲染的模式
    //即imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
    
    HWNavigationController* nav=[[HWNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}



/*//3.设置子控制器原始代码，未抽取方法
 UIViewController* vc1=[[UIViewController alloc]init];
 vc1.tabBarItem.title=@"首页";
 vc1.tabBarItem.image = [[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc1.view.backgroundColor = RandomColor;
 //设置未选中文字的样式
 NSMutableDictionary* textAttrs=[NSMutableDictionary dictionary];
 textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
 [vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
 //设置选中文字的样式
 NSMutableDictionary* seltextAttrs=[NSMutableDictionary dictionary];
 seltextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
 [vc1.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
 
 
 UIViewController* vc2=[[UIViewController alloc]init];
 vc2.tabBarItem.title=@"消息";
 vc2.tabBarItem.image = [[UIImage imageNamed:@"2.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"6.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc2.view.backgroundColor = RandomColor;
 [vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
 [vc2.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
 
 UIViewController* vc3=[[UIViewController alloc]init];
 vc3.tabBarItem.title=@"发现";
 vc3.tabBarItem.image = [[UIImage imageNamed:@"3.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"1.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc3.view.backgroundColor = RandomColor;
 [vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
 [vc3.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
 
 UIViewController* vc4=[[UIViewController alloc]init];
 vc4.tabBarItem.title=@"我";
 vc4.tabBarItem.image = [[UIImage imageNamed:@"4.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"2.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 vc4.view.backgroundColor = RandomColor;
 [vc4.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
 [vc4.tabBarItem setTitleTextAttributes:seltextAttrs forState:UIControlStateSelected];
 //注意：如果直接给一张图片会被渲染成默认的颜色，所以要设置为不要被渲染的模式
 //即imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
