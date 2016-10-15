//
//  HWAccount.h
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject <NSCoding>
/*
 access_token:用于调用access_token，接口获取授权后的access token。
 expires_in:access_token的生命周期，单位是秒数。
 uid:授权用户的UID。
 */
@property (copy,nonatomic) NSString *access_token;
@property (copy,nonatomic) NSString *expires_in;
@property (copy,nonatomic) NSString *uid;
//access_token的创建时间
@property (strong,nonatomic) NSDate *created_time;

+ (instancetype)accountWithDic:(NSDictionary *)dict;
@end
