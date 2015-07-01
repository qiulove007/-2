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
#import "UIImageView+WebCache.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWLoadMoreFooter.h"
#import "HWStatusCell.h"
#import "HWStatusFrame.h"
#import "HWStatusFrame.h"

@interface HWHomeViewController ()
/**
 *  微博数组（里面放得都是字典，一个字典就是一个微博）
 */
@property (nonatomic,strong)NSMutableArray* statuses;
@property(nonatomic,strong) NSMutableArray* statusFrames;
@end

@implementation HWHomeViewController

- (NSMutableArray*) statuses
{
    if(!_statuses)
    {
        self.statuses=[[NSMutableArray alloc] init];
    }
    return _statuses;
}

- (NSMutableArray*) statusFrames
{
    if(!_statusFrames)
    {
        self.statusFrames=[[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    CGFloat top=HWStatusCellMargin;
    self.tableView.contentInset =UIEdgeInsetsMake(top, 0, 0, 0);
    
    //设置导航栏内容
    [self setControllerContent];
    
    //获得用户信息
    [self setUserInfo];
    
    //获得最新的微博数据
    [self setNewStatus];
    
    //集成刷新控件
    [self setupRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];
    
    //获得未读数
    NSTimer* timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupreadCount) userInfo:nil repeats:YES];
    
    //主线程也会抽时间处理一下timer（不管主线程是否正在处理其他事件）
    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)setupreadCount
{
    AFHTTPRequestOperationManager* mgr=[AFHTTPRequestOperationManager manager];
    
    HWAccount* acc=[HWAccountTool account];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"access_token"]=acc.access_token;
    params[@"uid"]=acc.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //HWLog(@"%@",responseObject);
        //得到未读的微博数量
        int status = [responseObject[@"status"] intValue];
        
        //设置提醒数字
        if(status>0)
        {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status ];
            [self getAuth];
            [UIApplication sharedApplication].applicationIconBadgeNumber = status;
        }
        else
        {
            self.tabBarItem.badgeValue=nil;
            [self getAuth];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败+%@",error);
    }];
}

-(void) getAuth
{
    //对用户进行授权以显示图标右上角提醒数字
    UIUserNotificationSettings *set=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:set];
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

/**
 *  集成刷新控件
 */
-(void)setupRefresh
{
    UIRefreshControl* control=[[UIRefreshControl alloc]init];
    //只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //马上进入刷新状态（仅仅是刷新状态，并不会触发事件）
    [control beginRefreshing];
    
    //手动加载数据
    [self loadNewStatus:control];
}

-(void)setupUpRefresh
{
    self.tableView.tableFooterView = [HWLoadMoreFooter footer];
}

/**
 *  进入刷新状态，加载最新数据
 */
-(void)loadNewStatus:(UIRefreshControl*)sender
{
    //请求地址为：https://api.weibo.com/2/statuses/friends_timeline.json
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    HWAccount* acc=[HWAccountTool account];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"access_token"]=acc.access_token;
    //HWStatus* first=[self.statuses firstObject];//取出目前最新的一条微博
    HWStatusFrame* first=[self.statusFrames firstObject];
    params[@"since_id"]=first?first.status.idstr:@0;//since_id:指定该参数，则返回比该id大的微博信息
    //参数：max_id:返回ID小于或者等于max_id的微博，默认为0；
    
    //发送请求，要求发送get请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //HWLog(@"请求用户信息成功--%@",responseObject);
        //取得微博字典数组
        NSArray* dictArr  = responseObject[@"statuses"];
        NSMutableArray* newStatuses=[NSMutableArray array];
        NSMutableArray* newStatusFrame=[NSMutableArray array];
        
        //将微博字典数组转换为微博模型数组
        for (NSDictionary* dict in dictArr) {
            [newStatuses addObject:[HWStatus statusWithDict:dict]];
        }
        
        //将微博模型数组转成更加复杂的StatusFrame数组
        for(HWStatus* status in newStatuses)
        {
            HWStatusFrame* f=[[HWStatusFrame alloc]init];
            f.status = status;
            [newStatusFrame addObject:f];
        }
        
        //将最新的微博数据，添加到总数组的最前面
        NSRange range=NSMakeRange(0, newStatuses.count);
        NSRange rangeF=NSMakeRange(0,newStatusFrame.count);
        NSIndexSet* set=[NSIndexSet indexSetWithIndexesInRange:range];
        NSIndexSet* setF=[NSIndexSet indexSetWithIndexesInRange:rangeF];
        [self.statuses insertObjects:newStatuses atIndexes:set];
        [self.statusFrames insertObjects:newStatusFrame atIndexes:setF];
        //刷新table
        [self.tableView reloadData];
        
        //结束刷新
        [sender endRefreshing];
        
        //显示最新微博数据量
        [self showNewStatusCount:newStatuses.count];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求用户信息失败,%@",error);
        [sender endRefreshing];
    }];
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
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //HWLog(@"请求用户信息成功--%@",responseObject);
        
        //获取姓名
        HWUser* user=[HWUser userWithDict:responseObject];
        [((UIButton*)self.navigationItem.titleView) setTitle:user.name forState:UIControlStateNormal];
        //保存昵称进沙盒
        acc.name=user.name;
        [HWAccountTool saveAccount:acc];
        
        //HWLog(@"%@",name);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求用户信息失败+%@",error);
    }];
}

//获得最新的微博数据,关注的朋友的微博信息
-(void)setNewStatus
{
    //请求地址为：https://api.weibo.com/2/statuses/friends_timeline.json
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    HWAccount* acc=[HWAccountTool account];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"access_token"]=acc.access_token;
    //params[@"count"]=@2;//一次返回2条数据
    
    //发送请求，要求发送get请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HWLog(@"请求用户信息成功--");//%@",responseObject);
        //取得微博字典数组
        NSArray* dictArr  = responseObject[@"statuses"];
        
        //将微博字典数组转换为微博模型数组
        for (NSDictionary* dict in dictArr) {
            [self.statuses addObject:[HWStatus statusWithDict:dict]];
            HWStatusFrame* f=[[HWStatusFrame alloc]init];
            f.status=[HWStatus statusWithDict:dict];
            [self.statusFrames addObject:f];
        }

        //刷新table
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求用户信息失败,%@",error);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* ID=@"status";
    //获得cell
    HWStatusCell* cell=[HWStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
//    if(indexPath.row<self.statuses.count)
//    {
    
//        if(!cell)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
        //取出对应行的微博字典
        //NSDictionary* status=self.statuses[indexPath.row];
        //对出对应行的微博模型
//        HWStatus* status=self.statuses[indexPath.row];
//        
//        //取出这条微博的用户字典
//        HWUser* user=status.user;
//        cell.textLabel.text=user.name;
//        
//        //设置微博的主要内容
//        cell.detailTextLabel.text = status.text;
//        
//        //设置头像
//        NSString* imageURL=user.profile_name_url;
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"zx"]];
//    }
//    else
//    {
//        if(!cell)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//            cell.textLabel.text=@"加载新数据";
//        }
//    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusFrame * frame=self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

/**
 *  横条显示最新微博的数量
 *
 *  @param count 数量
 */
-(void)showNewStatusCount:(int)count
{
    //清空提示图标数字
    self.tabBarItem.badgeValue=nil;
    [self getAuth];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //创建label
    UILabel* label=[[UILabel alloc]init];
    label.backgroundColor = [UIColor orangeColor];
    label.height = 35;
    label.width = [UIScreen mainScreen].bounds.size.width;
    
    //设置其他属性
    if(count==0)
    {
        label.text=@"没有更新的微博数据，请稍后再试";
    }
    else
    {
        label.text=[NSString stringWithFormat:@"共有%d条更新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //添加label
    label.y = 64-label.height;
    //[self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //添加动画特效
    [UIView animateWithDuration:2.0 animations:^{
        label.y+=label.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:1.5 options:UIViewAnimationCurveLinear animations:^{
            label.y-=label.height;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];//销毁自己
        }];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.statusFrames.count ==0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY=scrollView.contentOffset.y;
    
    CGFloat judgeOffsetY=scrollView.contentSize.height+scrollView.contentInset.bottom-scrollView.height-self.tableView.tableFooterView.height;
    
    if(offsetY>=judgeOffsetY)
    {
        self.tableView.tableFooterView.hidden=NO;
        [self loadMoreStatus];
    }
}

-(void) loadMoreStatus
{
    AFHTTPRequestOperationManager* mgr=[AFHTTPRequestOperationManager manager];
    
    HWAccount* acc=[HWAccountTool account];
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"access_token"]=acc.access_token;
    
    HWStatusFrame* lastStatusF=[self.statusFrames lastObject];
    if(lastStatusF)
    {
        long long maxID=lastStatusF.status.idstr.longLongValue-1;
        params[@"max_id"]=@(maxID);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSArray* dictArr  = responseObject[@"statuses"];
        NSMutableArray* newStatuses=[NSMutableArray array];
        NSMutableArray* newStatusFrame=[NSMutableArray array];
        
        //将微博字典数组转换为微博模型数组
        for (NSDictionary* dict in dictArr) {
            [newStatuses addObject:[HWStatus statusWithDict:dict]];
        }
        
        //将微博模型数组转成更加复杂的StatusFrame数组
        for(HWStatus* status in newStatuses)
        {
            HWStatusFrame* f=[[HWStatusFrame alloc]init];
            f.status = status;
            [newStatusFrame addObject:f];
        }
        
        [self.statusFrames addObjectsFromArray:newStatusFrame];
        
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden =YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"获取数据失败：%@",error);
        self.tableView.tableFooterView.hidden =YES;
    }];
}

@end
