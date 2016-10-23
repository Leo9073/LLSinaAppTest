//
//  HWTextView.m
//  LLSinaApp
//
//  Created by Leo on 10/23/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWTextView.h"

@implementation HWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //通过通知
        //当UItextView的文字发生改变时，UItextView自己会发出一个UITextViewTextDidChangeNotification通知
        [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = [placeholderColor copy];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //如果有输入文字，直接返回，不画占位文字
    if (self.hasText) return;
    //没有文字，显示占位文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    CGRect placeholderRect = CGRectMake(5, 8, rect.size.width-10, rect.size.height-18);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)dealloc {
    
    [HWNotificationCenter removeObserver:self];
}

@end
