//
//  HWTextView.h
//  LLSinaApp
//
//  Created by Leo on 10/23/16.
//  Copyright © 2016 Leo. All rights reserved.
//  带有占位文字的textView

#import <UIKit/UIKit.h>

@interface HWTextView : UITextView
/** 占位文字 */
@property (copy,nonatomic) NSString *placeholder;
/** 占位文字颜色 */
@property (strong,nonatomic) UIColor *placeholderColor;
@end
