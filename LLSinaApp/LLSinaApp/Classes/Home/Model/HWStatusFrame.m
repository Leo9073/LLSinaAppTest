//
//  HWStatusFrame.m
//  LLSinaApp
//
//  Created by Leo on 10/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusFrame.h"

//cell的边框宽度
#define HWStatusCellBorderW 10


@implementation HWStatusFrame

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font withMaxW:(CGFloat)maxW {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font {
    
    return [self sizeWithText:text withFont:font withMaxW:MAXFLOAT];
}

- (void)setStatus:(HWStatus *)status {
    
    _status = status;
    HWUser *user = status.user;
    //cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF)+HWStatusCellBorderW;
//
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /** 头像图标 */
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    /** 配图 */
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF)+HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name withFont:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF)+HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF)+HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at withFont:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF)+HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source withFont:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+HWStatusCellBorderW;
    CGFloat maxW = cellW - 2*contentX;
    CGSize contentSize = [self sizeWithText:status.text withFont:HWStatusCellContentFont withMaxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /** cell的高度 */
    self.cellHeight = 250;

}

@end
