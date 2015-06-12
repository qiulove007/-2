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
{//需要判断不是根视图控制器的才添加左右按钮
    
    
    if(self.viewControllers.count>0)//判断大于第一层（根视图控制器）
    {
        viewController.hidesBottomBarWhenPushed=YES;//当push到下一个页面时隐藏tabbar
        
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(toBack:) image:@"1" highImage:@"3"];
        
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(toHome::) image:@"2" highImage:@"4"];
    }
    
    [super pushViewController:viewController animated:animated];
    
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
