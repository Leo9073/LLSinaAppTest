//
//  NSString+Extension.h
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font withMaxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
@end
