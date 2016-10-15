//
//  HWAccountTool.m
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "HWAccountTool.h"
#import "HWAccount.h"

//账号的存储路径
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation HWAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(HWAccount *)account {
    
        
    //自定义对象的存储必须用NSKeyedArchiver，不能使用writeToFile
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

/**
 *  返回账号信息(如果账号过期，返回nil)
 *
 *  @return 账号模型
 */
+ (HWAccount *)account {
    
    //加载模型
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    //验证账号是否过期
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    //获得过期的时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *now = [NSDate date];
    
    //如果now大于等于expiresTime，过期
    /**
     *  NSOrderedAscending = -1L, 升序，右边＞左边
     * NSOrderedSame, 一样
     * NSOrderedDescending 降序，右边＜左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { //过期
        return nil;
    }
    return account;
}

@end
