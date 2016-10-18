//
//  HWUser.h
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface HWUser : NSObject

/** idstr	string	字符串型的用户UID */
@property (copy,nonatomic) NSString *idstr;

/** name	string	友好显示名称 */
@property (copy,nonatomic) NSString *name;

/** profile_image_url	string	用户头像地址（中图），50×50像素 */
@property (copy,nonatomic) NSString *profile_image_url;

/** 会员类型 值 > 2才代表是会员 */
@property (assign,nonatomic) NSInteger mbtype;

/** 会员等级 */
@property (assign,nonatomic) NSInteger mbrank;

@property (assign,nonatomic, getter=isVip) BOOL vip;

@end
