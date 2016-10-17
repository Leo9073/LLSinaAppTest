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

@end
