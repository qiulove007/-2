//
//  HWNavigationController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWNavigationController.h"

@interface HWNavigationController ()

@end

@implementation HWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];
    UIButton* back=[UIButton buttonWithType:UIButtonTypeCustom];//创建一个自定义的按钮
    [back addTarget:self action:@selector(toBack:) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateHighlighted];
    back.size = back.currentBackgroundImage.size;//如果没有正常显示，请查看有没有设置大小
    viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:back];
    
    UIButton* home=[UIButton buttonWithType:UIButtonTypeCustom];//创建一个自定义的按钮
    [home addTarget:self action:@selector(toHome:) forControlEvents:UIControlEventTouchUpInside];
    [home setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [home setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateHighlighted];
    home.size=home.currentBackgroundImage.size;//如果没有正常显示，请查看有没有设置大小
    viewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:home];
}

-(void)toBack:(id)sender
{
    [self popViewControllerAnimated:YES];//返回上一个viewController
}

-(void)toHome:(id)sender
{
    [self popToRootViewControllerAnimated:YES];//返回根视图viewController
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
