//
//  HWStatus.h
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
#import "HWUser.h"

@interface HWStatus : NSObject
/** idstr	string	字符串型的微博ID */
@property (copy,nonatomic) NSString *idstr;

/** text	string	微博信息内容 */
@property (copy,nonatomic) NSString *text;

/** user	object	微博作者的用户信息字段 详细 */
@property (strong,nonatomic) HWUser *user;

/** created_at	微博创建时间 */
@property (copy,nonatomic) NSString *created_at;

/** source	微博来源 */
@property (copy,nonatomic) NSString *source;

/** pic_urls	配图 */
@property (strong,nonatomic) NSArray *pic_urls;

/** 被转发微博 */
@property (strong,nonatomic) HWStatus *retweeted_status;

/** 转发数 */
@property (assign,nonatomic) NSInteger reposts_count;

/** 评论数 */
@property (assign,nonatomic) NSInteger comments_count;

/** 表态数 */
@property (assign,nonatomic) NSInteger attitudes_count;

@end
