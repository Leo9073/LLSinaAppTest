//
//  HWAccountTool.h
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
// 处理账号相关的所有信息:存储账号，取出账号，验证账号

#import <Foundation/Foundation.h>
#import "HWAccount.h"

@interface HWAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(HWAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (HWAccount *)account;
@end
