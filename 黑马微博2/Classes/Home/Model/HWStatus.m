//
//  HWStatus.m
//  黑马微博2
//
//  Created by PC－qiu on 15/6/22.
//  Copyright (c) 2015年 HM. All rights reserved.
//  微博模型，保存用户信息字典，保存了多个HWUser的信息

#import "HWStatus.h"
#import "HWUser.h"
#import "HWPhoto.h"

@implementation HWStatus

+(instancetype)statusWithDict:(NSDictionary*)dict
{
    HWStatus* status=[[self alloc]init];
    status.idstr=dict[@"idstr"];
    status.user=[HWUser userWithDict:dict[@"user"]];
    status.text=dict[@"text"];
    status.created_at = dict[@"created_at"];
    status.source = dict[@"source"];
    status.pic_urls=dict[@"pic_urls"];
    status.reposts_count = (int)dict[@"reposts_count"];
    status.comments_count = (int)dict[@"comments_count"];
    status.attitudes_count = (int)dict[@"attitudes_count"];
    status.retweeted_status = dict[@"retweeted_status"];
    return status;
}

-(void)setRetweeted_status:(NSDictionary *)retweeted_status
{
    _retweeted_status=[[HWStatus alloc]init];
    if(retweeted_status)
    {
        _retweeted_status.idstr=retweeted_status[@"idstr"];
        _retweeted_status.user=[HWUser userWithDict:retweeted_status[@"user"]];
        _retweeted_status.text=retweeted_status[@"text"];
        _retweeted_status.created_at = retweeted_status[@"created_at"];
        _retweeted_status.source = retweeted_status[@"source"];
        _retweeted_status.pic_urls=retweeted_status[@"pic_urls"];
        _retweeted_status.reposts_count = (int)retweeted_status[@"reposts_count"];
        _retweeted_status.comments_count = (int)retweeted_status[@"comments_count"];
        _retweeted_status.attitudes_count = (int)retweeted_status[@"attitudes_count"];
    }else
        _retweeted_status=nil;
}

-(void)setSource:(NSString *)source
{
    
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location+1;//得到第一个>的下标
    range.length= [source rangeOfString:@"</"].location - range.location;//得到<a>与</a>之间内容的长度
    HWLog(@"location:%d,length:%d",range.location,range.length);
    _source=[NSString stringWithFormat:@"来自%@",[source substringWithRange:range] ];
}


-(NSString*)created_at
{
    //日期格式化对象
    NSDateFormatter* fmt=[[NSDateFormatter alloc]init];
    //如果是真机调试，需要设置locale，指定本机时区
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];//设置为美国，或者zh_cn
    
    //设置日期格式(说明字符串中每个数字和单词的含义)，
    //日期范例：   Thu Oct 16 17:00:01 +0800 2013
    //dateFormat:EEE MMM dd HH:mm:ss Z yyyy;  E:星期几，M:月份，d:几号（本月天数），H:24小时值小时，h：12小时制小时，m:分钟，s:秒，y:年，Z:+0800(时区)
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy;";
    //通过格式化对象将NSString转换为NSDate
    
    
    NSDate* createdDate=[fmt dateFromString:_created_at];
    
    //!!关于日期的诸多判断，可以去扩展NSDate来进行实现，现在暂时不扩展
    
    //获得当前日期
    NSDate* now=[NSDate date];
    //日历对象(方便比较两个日期之间的差距)
    NSCalendar* ca=[NSCalendar currentCalendar];
    //NSCalendarUnit设置需要去比较的日期内容
    NSCalendarUnit* unit= NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents* cmps=[ca components:unit fromDate:createdDate toDate:now options:0];
    
    //得到createdDate这个日期的具体unit对应的值
    NSDateComponents* createDateCmps = [ca components:unit fromDate:createdDate];
    //得到createdDate这个日期的具体unit对应的值
    NSDateComponents* nowCmps = [ca components:unit fromDate:now];
    
    NSString* result=@"";
    
    if(createDateCmps.year == nowCmps.year)
    {//今年内
        if(cmps.month == 0 && cmps.day==0 && cmps.hour==0 && cmps.minute == 0)
        {//刚刚:1分钟内
            result=@"刚刚";
        }
        else if(cmps.month==0 && cmps.day==0 && cmps.hour == 0)
        {//XX分钟前：1~59分钟
            result=[NSString stringWithFormat:@"%d分钟前",cmps.minute];
        }
        else if(cmps.month==0&&cmps.day==0)
        {//xx小时前：1~23小时内
            result=[NSString stringWithFormat:@"%d小时前",cmps.hour];
        }
        else if(cmps.month==0 && cmps.day==1)
        {//昨天 xx:xx：24~47小时
            result=@"昨天";
        }
        else
        {//xx-xx xx:xx：今年内
            fmt.dateFormat = @"MM-dd HH:mm";
            result = [fmt stringFromDate:createdDate];
            
        }
    }
    else
    {//不是今年，就显示xxxx-xx-xx xx:xx：非今年内
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        result = [fmt stringFromDate:createdDate];
    }
    //    //设置新的日期格式
    //    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    return [fmt stringFromDate:createdDate];
    
    return result;
}

//-(NSDictionary*) objectClassInArray
//{
//    return @{@"pic_urls" : [HWPhoto class]};
//}
-(void) setPic_urls:(NSMutableArray *)pic_urls
{
    _pic_urls=[[NSMutableArray alloc]init];
    int count=pic_urls.count;
    for(int i=0;i<count;i++)
    {
        NSDictionary* dict=[pic_urls objectAtIndex:i];
        HWPhoto* photo =[HWPhoto photoWithDict:dict];
        [_pic_urls addObject:photo];
        //HWLog(@"%@",photo.thumbnail_pic);
    }
}
@end
