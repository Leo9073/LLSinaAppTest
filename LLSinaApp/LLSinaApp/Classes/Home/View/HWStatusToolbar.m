//
//  HWStatusToolbar.m
//  LLSinaApp
//
//  Created by Leo on 10/19/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusToolbar.h"

@interface HWStatusToolbar ()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostButton;
@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIButton *attitudeButton;
@end

@implementation HWStatusToolbar

/**
 *  放所有的按钮
 */
- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

/**
 *  放所有的分割线
 */
- (NSMutableArray *)dividers {
    
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}


+ (instancetype)toolbar {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostButton = [self setupButtonWithTitle:@"转发" withIcon:@"timeline_icon_retweet"];
        self.commentButton = [self setupButtonWithTitle:@"评论" withIcon:@"timeline_icon_comment"];
        self.attitudeButton = [self setupButtonWithTitle:@"赞" withIcon:@"timeline_icon_unlike"];
        
        //添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}


/**
 *  初始化按钮
 *
 *  @param title 按钮文字
 *  @param icon  图片名字
 */
- (UIButton *)setupButtonWithTitle:(NSString *)title withIcon:(NSString *)icon {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    [self.buttons addObject:button];
    return button;
}

- (void)layoutSubviews {
    
    NSInteger buttonCount = self.buttons.count;
    CGFloat buttonW = self.width/buttonCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = self.buttons[i];
        button.y = 0;
        button.x = i * buttonW;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 设置分割线的frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = buttonH;
        divider.x = (i + 1) * buttonW;
        divider.y = 0;
    }
}

- (void)setStatus:(HWStatus *)status {
    
    _status = status;
    [self setupButtonCount:status.reposts_count withButton:self.repostButton withTitle:@"转发"];
    [self setupButtonCount:status.comments_count withButton:self.commentButton withTitle:@"评论"];
    [self setupButtonCount:status.attitudes_count withButton:self.attitudeButton withTitle:@"赞"];
}

- (void)setupButtonCount:(NSInteger)count withButton:(UIButton *)button withTitle:(NSString *)title {
    
    if (count) { //有转发、评论和赞
        if (count < 10000) { //如果小于10000直接显示数字
            title = [NSString stringWithFormat:@"%ld",count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [button setTitle:title forState:UIControlStateNormal];
}

@end
