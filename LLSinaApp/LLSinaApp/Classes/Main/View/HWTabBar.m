//
//  HWTabBar.m
//  LLSinaApp
//
//  Created by Leo on 10/14/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWTabBar.h"

@interface HWTabBar ()
@property (weak,nonatomic) UIButton *plusButton;
@end

@implementation HWTabBar
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个按钮到tabbar中
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.size = plusButton.currentBackgroundImage.size;
        //设置监听
        [plusButton addTarget:self action:@selector(plusClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

/**
 *  加号按钮点击事件
 */
- (void)plusClicked {
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  重写layoutSubviews方法
 */
- (void)layoutSubviews {
    
#warning [super layoutSubviews] 一定要调用
    [super layoutSubviews];
    
    //设置加号按钮的位置
    self.plusButton.centerX = self.width*0.5;
    self.plusButton.centerY = self.height*0.5;
    
    //设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonWidth = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //HWLog(@"系统自带按钮");
            //设置宽度
            child.width = tabbarButtonWidth;
            //设置x
            child.x = tabbarButtonIndex * tabbarButtonWidth;
            //child.backgroundColor = [UIColor redColor];
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
    }
}

@end
