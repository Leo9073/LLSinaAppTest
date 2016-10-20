//
//  NSString+Extension.m
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//  计算字体的大小

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font withMaxW:(CGFloat)maxW {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    
    return [self sizeWithFont:font withMaxW:MAXFLOAT];
}
@end
