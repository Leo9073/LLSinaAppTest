//
//  HWStatus.m
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatus.h"
#import "HWUser.h"
#import "HWPhoto.h"
#import <MJExtension.h>

@implementation HWStatus

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"pic_urls" : [HWPhoto class]};
}

- (NSString *)created_at {
    
    /**
     1.今年
     1> 今天
     * 1分钟内：刚刚
     * 1-59分钟：xx分钟前
     * 大于60分钟：xx小时前
     
     2> 昨天
     * xx:xx
     
     3> 其他
     * xx-xx xx:xx
     
     2.非今年
     xxxx-xx-xx xx:xx
     */
    
    //_created_at = Wed Oct 19 20:07:54 +0800 2016
    //dateFormat = EEE MMM dd HH:mm:ss Z yyyy
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //如果是真机调试，转换这种时间，需要设置locale
    //设置日期格式，声明字符串里面每个数字和单词的含义
    //E:星期几
    //M:月份
    //d:几号
    //H:24小时制的小时
    //m:分钟
    //s:秒
    //Z:时区
    //y:年份
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象，方便比较两个日期之间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
//    //获得某个时间的年月日时分秒
//    NSDateComponents *createdDateCmps = [calendar components:unit fromDate:createDate];
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    //没思路可以先写伪代码
    
    if ([createDate isThisYear]) {  //今年
        if ([createDate isYesterday]) { //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { //今天
            if (cmps.hour > 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

@end
