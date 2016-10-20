//
//  HWStatusCell.m
//  LLSinaApp
//
//  Created by Leo on 10/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusCell.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#import "HWStatusToolbar.h"
#import "HWStatusFrame.h"

@interface HWStatusCell ()
/** 原创微博 */
@property (weak,nonatomic) UIView *originalView;

/** 头像图标 */
@property (weak,nonatomic) UIImageView *iconView;

/** 配图 */
@property (weak,nonatomic) UIImageView *photoView;

/** 会员图标 */
@property (weak,nonatomic) UIImageView *vipView;

/** 昵称 */
@property (weak,nonatomic) UILabel *nameLabel;

/** 时间 */
@property (weak,nonatomic) UILabel *timeLabel;

/** 来源 */
@property (weak,nonatomic) UILabel *sourceLabel;

/** 正文 */
@property (weak,nonatomic) UILabel *contentLabel;

/** 转发微博 */
/** 转发微博整体 */
@property (weak,nonatomic) UIView *retweetView;

/** 转发微博正文+昵称 */
@property (weak,nonatomic) UILabel *retweetContentLabel;

/** 转发微博配图 */
@property (weak,nonatomic) UIImageView *retweetPhotoView;

/** 工具条 */
@property (weak,nonatomic) HWStatusToolbar *toobar;

/** 转发微博正文+昵称 */
//@property (weak,nonatomic) UILabel *retweetContentLabel;

/** 转发微博配图 */
//@property (weak,nonatomic) UIImageView *retweetPhotoView;

@end

@implementation HWStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"cell";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次，一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //初始化工具条
        [self setupToolbar];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
//    
//    frame.origin.y += HWStatusCellMargin;
//    [super setFrame:frame];
//}

/**
 *  初始化工具条
 */
- (void)setupToolbar {
    
    HWStatusToolbar *toolbar = [HWStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toobar = toolbar;
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet {
    
    //1、转发微博整体
    /** 转发微博 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = HWColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文+昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = HWStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal {
    
    //1、原创微博整体
    /** 原创微博 */
    UIView *originalView = [[UIImageView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像图标 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HWStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel =[[UILabel alloc] init];
    timeLabel.font = HWStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = HWStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = HWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)setStatusFrame:(HWStatusFrame *)statusFrame {
    
    _statusFrame = statusFrame;
    
    HWStatus *status = statusFrame.status;
    HWUser *user = status.user;
    
    /** 原创微博 */
    self.originalView.frame = statusFrame.originalViewF;;
    
    /** 头像图标 */
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        HWPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO; //防止循环引用
    } else {
        self.photoView.hidden = YES; //防止循环引用
    }
    
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%ld",user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF)+HWStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:HWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.nameLabel.frame)+HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    /** 被转发的微博 */
    if (status.retweeted_status) {
        
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        self.retweetView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = retweetContent;
        
        /** 配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            HWPhoto *retweetedPhoto = [retweeted_status.pic_urls firstObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.hidden = NO; //防止循环引用
        } else {
            self.retweetPhotoView.hidden = YES; //防止循环引用
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
    /**  */
    self.toobar.frame = statusFrame.toolbarF;
    self.toobar.status = status;
}

@end
