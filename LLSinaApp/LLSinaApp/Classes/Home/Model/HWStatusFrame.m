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

//cell之间的间距
#define HWStatusCellMargin 15


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
    
    /** 头像图标 */
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
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
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) +  HWStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoViewF)+HWStatusCellBorderW;
    } else { //没配图
        originalH = CGRectGetMaxY(self.contentLabelF)+HWStatusCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    //
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    
    /** 被转发微博 */
    if (status.retweeted_status) { //如果有转发微博才设置frame
        
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent withFont:HWStatusCellRetweetContentFont withMaxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { //微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) +  HWStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF)+HWStatusCellBorderW;
        } else { //微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF)+HWStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF)+HWStatusCellMargin;
    
}

@end
