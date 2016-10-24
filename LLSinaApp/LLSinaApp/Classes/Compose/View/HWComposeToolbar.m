//
//  HWComposeToolbar.m
//  LLSinaApp
//
//  Created by Leo on 10/23/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWComposeToolbar.h"

@implementation HWComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self creatButtonWithimage:@"compose_camerabutton_background" withHighlightedImage:@"compose_camerabutton_background_highlighted" withType:HWComposeToolbarButtonTypeCamera];
        
        [self creatButtonWithimage:@"compose_toolbar_picture" withHighlightedImage:@"compose_toolbar_picture_highlighted" withType:HWComposeToolbarButtonTypePicture];
        
        [self creatButtonWithimage:@"compose_mentionbutton_background" withHighlightedImage:@"compose_mentionbutton_background_highlighted" withType:HWComposeToolbarButtonTypeMention];
        
        [self creatButtonWithimage:@"compose_trendbutton_background" withHighlightedImage:@"compose_trendbutton_background_highlighted" withType:HWComposeToolbarButtonTypeTrend];
        
        
        [self creatButtonWithimage:@"compose_emoticonbutton_background" withHighlightedImage:@"compose_emoticonbutton_background_highlighted" withType:HWComposeToolbarButtonTypeEmotion];
    }
    return self;
}


/**
 *  创建一个button
 */
- (void)creatButtonWithimage:(NSString *)image withHighlightedImage:(NSString *)highlightedImage withType:(HWComposeToolbarButtonType)type {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = type;
    [self addSubview:button];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.x = i * buttonW;
        button.width = buttonW;
        button.height = buttonH;
    }
}

- (void)buttonClicked:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:(int)button.tag];
    }
}

@end
