//
//  HWStatusFrame.h
//  LLSinaApp
//
//  Created by Leo on 10/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//  一个HWStatusFrame模型里面包含的信息：
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus

#import <Foundation/Foundation.h>
#import "HWStatus.h"

//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]

//时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]

//来源字体
#define HWStatusCellSourceFont HWStatusCellTimeFont

//正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14]

@interface HWStatusFrame : NSObject

@property (strong,nonatomic) HWStatus *status;

/** 原创微博整体 */
@property (assign,nonatomic) CGRect originalViewF;

/** 头像图标 */
@property (assign,nonatomic) CGRect iconViewF;

/** 配图 */
@property (assign,nonatomic) CGRect photoViewF;

/** 会员图标 */
@property (assign,nonatomic) CGRect vipViewF;

/** 昵称 */
@property (assign,nonatomic) CGRect nameLabelF;

/** 时间 */
@property (assign,nonatomic) CGRect timeLabelF;

/** 来源 */
@property (assign,nonatomic) CGRect sourceLabelF;

/** 正文 */
@property (assign,nonatomic) CGRect contentLabelF;

/** cell的高度 */
@property (assign,nonatomic) CGFloat cellHeight;
@end
