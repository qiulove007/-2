//
//  HWComposeViewController.m
//  黑马微博2
//
//  Created by PC－qiu on 15/7/6.
//  Copyright (c) 2015年 HM. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "MBProgressHUD.h"
#import "HWPlaceholderTextView.h"
#import "AFNetworking.h"
#import "HWComposeToolbar.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposePhotosView.h"

@interface HWComposeViewController ()<UITextViewDelegate , HWComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**
 *  输入控件，带等待文字信息的TextView
 */
@property (nonatomic,weak) HWPlaceholderTextView* textView;
/**
 *  键盘上方的工具条
 */
@property (nonatomic,strong) HWComposeToolbar* toolbar;
/** 相册（存放拍照或者相册中选择的图片） **/
@property (nonatomic ,weak) HWComposePhotosView* photosView;
@end

@implementation HWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航栏
    [self setupNav];
    //初始化输入控件
    [self setupTextView];
    //初始化工具条
    [self setupToolbar];
    //添加相册
    [self setupPhotosView];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    AFHTTPRequestOperationManager* mgr=[AFHTTPRequestOperationManager manager];
    if(self.photosView.Photos.count)
    {//可以进行封装
        //请求地址：https://upload.api.weibo.com/2/statuses/upload.json 这个地址用来发送带图片的微博
        //参数1（NSString）：status:微博信息内容 （必选）
        //参数2（NSString）：access_token      （必选）
        //参数3（NSData）：pic 微博配图          （必选）
        HWAccount* acc=[HWAccountTool account];
        NSMutableDictionary* params=[NSMutableDictionary dictionary];
        params[@"access_token"]=acc.access_token;
        params[@"status"]=self.textView.text;
        
        [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
             //拼接文件数据
             UIImage* img=[self.photosView.Photos firstObject];
             NSData* data=UIImageJPEGRepresentation(img, 1.0);
             [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
         }success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
            //HWLog(@"%@",responseObject);
            //得到未读的微博数量
             [MBProgressHUD showMessage:@"发送微博成功"];
            HWLog(@"发送微博成功");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showMessage:@"发送微博失败"];
            HWLog(@"发送微博失败+%@",error);
        }];

    }
    else{
        //请求地址：https://api.weibo.com/2/statuses/update.json  这个地址是发送纯文字微博
        //参数1（NSString）：status:微博信息内容 （必选）
        //参数2（NSString）：access_token      （必选）
        HWAccount* acc=[HWAccountTool account];
        NSMutableDictionary* params=[NSMutableDictionary dictionary];
        params[@"access_token"]=acc.access_token;
        params[@"status"]=self.textView.text;
        
        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
            //HWLog(@"%@",responseObject);
            //得到未读的微博数量
            HWLog(@"发送微博成功");
            [MBProgressHUD showMessage:@"发送微博成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            HWLog(@"发送微博失败+%@",error);
            [MBProgressHUD showMessage:@"发送微博失败"];
        }];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
/**
 *  初始化输入控件
 */
-(void)setupTextView
{
    HWPlaceholderTextView* textView=[[HWPlaceholderTextView alloc]init];
    textView.alwaysBounceVertical = YES;//垂直方向一致可以拉
    textView.delegate = self;
    textView.frame=self.view.bounds;
    textView.font=[UIFont systemFontOfSize:15];
    textView.placeHolder=@"分享一些新鲜事儿";
    textView.placeHolderColor=[UIColor grayColor];
    
    [self.view addSubview:textView];
    self.textView=textView;
    
    //成为第一响应者，能输入文本的控件一旦成为第一响应者，自然会叫出键盘
    [textView becomeFirstResponder];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


/**
 *  初始化导航栏
 */
-(void) setupNav
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled=NO;//发送设置不能点
    
    
    NSString* name=[HWAccountTool account].name?[HWAccountTool account].name:@"";
    UILabel* titleView=[[UILabel alloc]init];
    titleView.width=200;
    titleView.height=44;
    titleView.textAlignment=NSTextAlignmentCenter;
    titleView.numberOfLines=0;//换行
    
    //创建一个带有属性的字符串（比如颜色属性，字体属性或者文字属性）
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"发微博\n%@",name]];
    
    //添加属性,设置3~end 下标的文字为黑色字体
    [text addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 3)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, name.length)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, name.length)];
    
    titleView.attributedText=text;
    
    self.navigationItem.titleView=titleView;
    
    
}


/**
 *  初始化工具条
 */
-(void)setupToolbar
{
    HWComposeToolbar* toolbar=[[HWComposeToolbar alloc]init];
    toolbar.width=self.view.width;
    toolbar.height=44;
    //inputView用来设置弹出键盘
    //self.textView.inputView = ....;
    //跟随键盘一起弹出
    //self.textView.inputAccessoryView=toolbar;
    toolbar.y=self.view.height-toolbar.height;
    
    //监听
    toolbar.delegate=self;
    
    [self.view addSubview:toolbar];
    self.toolbar=toolbar;
}

/**
 *  添加相册
 */
-(void)setupPhotosView
{
    HWComposePhotosView* photosView=[[HWComposePhotosView alloc]init];
    photosView.y=100;
    photosView.width=self.view.width;
    photosView.height=self.view.height;
    [self.textView addSubview:photosView];
    self.photosView=photosView;
}

/**
 *  监听文字改变
 */
-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled=self.textView.hasText;
}

-(void)dealloc
{
    //回收删除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  实现拖拽时将键盘回缩的功能，实现代理方法scrollViewWillBeginDragging来完成
 *
 *  @param scrollView UITextView
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  键盘发送改变时调用
 *
 *  @param notification 通知对象
 */
-(void)keyboardWillChangeFrame:(NSNotification*)notification
{
    NSDictionary* userInfo=notification.userInfo;
    //动画的持续时间
    double duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //让工具条跟随键盘
        self.toolbar.y=keyboardF.origin.y - self.toolbar.height;
    }];
}

-(void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)type
{
    switch (type) {
        case HWComposeToolbarButtonTypeCamera://拍照
            [self openCamera];
            break;
        case HWComposeToolbarButtonTypePicture://相册
            [self openAlbum];
            break;
        case HWComposeToolbarButtonTypeMention://@
            
            break;
        case HWComposeToolbarButtonTypeTrend://#
            
            break;
        case HWComposeToolbarButtonTypeEmotion://表情。键盘
            
            break;
        default:
            break;
    }
}

-(void) openCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController* ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void) openAlbum
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController* ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  从UIImagePickerController选择完图片后就调用该方法（拍照完毕或者选择相册图片完毕）
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //得到选中的图片
    UIImage* image=info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photosView中
    [self.photosView addPhoto:image];
}
@end
