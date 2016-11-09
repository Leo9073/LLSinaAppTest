//
//  HWEmotionTabBarButton.m
//  LLSinaApp
//
//  Created by Leo on 11/9/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWEmotionTabBarButton.h"

@implementation HWEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    //高亮状态没有了
}

@end
