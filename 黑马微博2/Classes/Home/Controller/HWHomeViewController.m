//
//  HWHomeViewController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/11.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWHomeViewController.h"
#import "AFNetworking.h"
#import "HWTitleButton.h"

@interface HWHomeViewController ()

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setControllerContent];
    
    //获得用户信息
    [self setUserInfo];
}

/**
 *  点击标题
 */
-(void)titleClick:(UIButton*) titleButton
{
    HWDropDownMenu* dropdownMenu=[HWDropDownMenu menu];
    
    dropdownMenu.content = [[UITableView alloc]initWithFrame:CGRectMake(0,0,200,200)];
    //显示窗口
    [dropdownMenu showFrom:titleButton];
    
    
}

-(void)toFriend
{
    
}

-(void)toPop
{
    
}

-(void)setUserInfo
{
    //请求地址为：https://api.weibo.com/2/users/show.json
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    HWAccount* acc=[HWAccountTool account];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"access_token"]=acc.access_token;
    params[@"uid"]= acc.uid;
    
    //发送请求，要求发送get请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //HWLog(@"请求用户信息成功--%@",responseObject);
        
        //获取姓名
        NSString* name=[responseObject[@"name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [((UIButton*)self.navigationItem.titleView) setTitle:name forState:UIControlStateNormal];
        //保存昵称进沙盒
        acc.name=name;
        [HWAccountTool saveAccount:acc];
        
        HWLog(@"%@",name);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求用户信息失败");
    }];
}

//设置导航栏内容
-(void) setControllerContent
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(toFriend) image:@"5" highImage:@"6"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(toPop) image:@"d_nu" highImage:@"1"];
    
    
    //添加标题按钮
    HWTitleButton* titleButton=[HWTitleButton buttonWithType:UIButtonTypeCustom];
//    titleButton.width=250;
//    titleButton.height=30;
    
    //设置按钮的图片和文字
    NSString* name=[HWAccountTool account].name;
    [titleButton setTitle:name?name:@"" forState:UIControlStateNormal];
    
    
    //监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //[titleButton sizeToFit];//内容有多少，按钮就有多大，autosize类似
    
    self.navigationItem.titleView = titleButton;//设置导航栏的标题视图为一个按钮
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
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
