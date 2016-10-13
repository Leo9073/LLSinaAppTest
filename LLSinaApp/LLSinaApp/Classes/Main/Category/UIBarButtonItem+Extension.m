//
//  UIBarButtonItem+Extension.m
//  LLSinaApp
//
//  Created by Leo on 10/13/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
//方法重构,避免重复代码太多
/**
 *  创建一个item
 *
 *  @param target           点击item后调用哪个方法
 *  @param action           点击item后调用target的方法
 *  @param image            图片
 *  @param highlightedImage 高亮图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target withAction:(SEL)action withImage:(NSString *)image withHighlightedImage:(NSString *)highlightedImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    //设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
