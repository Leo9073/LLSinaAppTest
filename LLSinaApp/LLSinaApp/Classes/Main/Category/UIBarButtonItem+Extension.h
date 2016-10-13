//
//  UIBarButtonItem+Extension.h
//  LLSinaApp
//
//  Created by Leo on 10/13/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target withAction:(SEL)action withImage:(NSString *)image withHighlightedImage:(NSString *)highlightedImage;
@end
