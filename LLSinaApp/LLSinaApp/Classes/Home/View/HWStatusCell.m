//
//  HWStatusCell.m
//  LLSinaApp
//
//  Created by Leo on 10/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusCell.h"
#import "UIImageView+WebCache.h"

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
       //1、原创微博整体
        /** 原创微博 */
        UIView *originalView = [[UIImageView alloc] init];
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
    return self;
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
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
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
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
}







@end
