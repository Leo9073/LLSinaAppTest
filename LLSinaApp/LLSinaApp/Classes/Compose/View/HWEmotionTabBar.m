//
//  HWEmotionTabBar.m
//  LLSinaApp
//
//  Created by Leo on 10/29/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWEmotionTabBar.h"
#import "HWEmotionTabBarButton.h"

@interface HWEmotionTabBar ()
@property (weak,nonatomic) HWEmotionTabBarButton *selectedButton;
@end

@implementation HWEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton:@"最近" buttonType:HWEmotionTabBarButtonTypeRecent];
        [self buttonClicked:[self setupButton:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault]];
        [self setupButton:@"Emoji" buttonType:HWEmotionTabBarButtonTypeEmoji];
        [self setupButton:@"浪小花" buttonType:HWEmotionTabBarButtonTypeLxh];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (HWEmotionTabBarButton *)setupButton:(NSString *)title buttonType:(HWEmotionTabBarButtonType)buttonType {
    
    HWEmotionTabBarButton *button = [[HWEmotionTabBarButton alloc] init];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [self addSubview:button];
    
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image =  @"compose_emotion_table_left_normal";
        selectedImage =  @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image =  @"compose_emotion_table_right_normal";
        selectedImage =  @"compose_emotion_table_right_selected";
    }
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return button;
}

/**
 *  布局
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSInteger buttonCount = self.subviews.count;
    CGFloat buttonW = self.width/buttonCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < buttonCount; i++) {
        HWEmotionTabBarButton *button = self.subviews[i];
        button.y = 0;
        button.x = i * buttonW;
        button.width = buttonW;
        button.height = buttonH;
    }
}

/**
 *  按钮点击事件
 *
 *  @param button 参数
 */
- (void)buttonClicked:(HWEmotionTabBarButton *)button {
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)button.tag];
    }
}

@end
