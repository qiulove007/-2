//
//  HWOAuthViewController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/17.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWAccount.h"
#import "MBProgressHUD.h"
#import "HWAccountTool.h"

@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建webview
    UIWebView* webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    //用webview加载页面
    /*
     请求地址：https://api.weibo.com/oauth2/authorize
     请求参数：1.client_id:申请应用时分配的appkey
              2.redirect_url:授权成功后的回调地址
     */
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1816487029&redirect_uri=http://www.baidu.com"];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{//拦截webview的所有请求
    //1.获得URL
    NSString* url=request.URL.absoluteString;
    
    //2.判断是否为回调地址
    NSRange range=[url rangeOfString:@"code="];
    if(range.length!=0)
    {//判断成功
        int fromIndex = range.location+range.length;
        NSString* code=[url substringFromIndex:fromIndex];
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        //禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功过的request token）换取一个accessToken
 *
 *  @param code code 授权成功过的标记
 */
-(void) accessTokenWithCode:(NSString*)code
{
    /*
     请求地址为https://api.weibo.com/oauth2/access_token
     请求参数有5个：client_id:申请应用时的appkey
     client_secret:申请应用时的appsecret
     grant_type:请求的类型，请填写authorization_code
     redirect_uri:授权成功后的回调地址
     code:授权成功后返回的code
     */
    //请求管理者
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //拼接请求字符串
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"client_id"] = @"1816487029";
    params[@"client_secret"]=@"51f16a8e74fa49acf28cdec33e74d839";
    params[@"grant_type"]=@"authorization_code";
    params[@"redirect_uri"]=@"http://www.baidu.com";
    params[@"code"]=code;
    
    //发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //将返回的账号数据，存储进沙盒
        //1.得到documents路径
//        NSString* doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        //2.得到拼接的保存路径
//        NSString* path=[doc stringByAppendingPathComponent:@"account.data"];
        //转换为HWAccount模型类
        HWAccount* acc=[HWAccount accountWithDict:responseObject];
        
        [HWAccountTool saveAccount:acc];
        //3.写入数据
        //[responseObject writeToFile:path atomically:YES];
        //3.写入数据，自定义对象的存储必须使用NSKeyedArchiver来进行，没有writeToFile.
        //[NSKeyedArchiver archiveRootObject:acc toFile:path];
        
        //切换窗口的根控制器
        UIWindow* window=[UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
    }];
}

/**
 *  webView结束读取
 *
 *  @param webView <#webView description#>
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

/**
 *  webView开始加载
 *
 *  @param webView <#webView description#>
 */
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

@end
