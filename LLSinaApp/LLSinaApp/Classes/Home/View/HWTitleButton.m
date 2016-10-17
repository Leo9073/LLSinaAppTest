//
//  HWTitleButton.m
//  LLSinaApp
//
//  Created by Leo on 16/10/16.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "HWTitleButton.h"
#define HWMargin 8

@implementation HWTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //测试用
//        self.backgroundColor = [UIColor redColor];
//        self.titleLabel.backgroundColor = [UIColor blueColor];
//        self.imageView.backgroundColor = [UIColor yellowColor];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  想在系统计算完按钮的尺寸后再修改尺寸,重写这个方法的目的是拦截设置尺寸的过程,如果想在系统设置完控件尺寸后，再做修改，并且要保证修改成功，一般都是在setFrame中设置
 */
- (void)setFrame:(CGRect)frame {
    
    frame.size.width += HWMargin;
    [super setFrame:frame];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    //1、计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
    //2、计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+HWMargin;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
