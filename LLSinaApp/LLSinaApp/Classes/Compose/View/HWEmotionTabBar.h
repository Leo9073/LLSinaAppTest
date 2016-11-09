//
//  HWEmotionTabBar.h
//  LLSinaApp
//
//  Created by Leo on 10/29/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWEmotionTabBarButtonTypeRecent,
    HWEmotionTabBarButtonTypeDefault,
    HWEmotionTabBarButtonTypeEmoji,
    HWEmotionTabBarButtonTypeLxh,
} HWEmotionTabBarButtonType;


@class HWEmotionTabBar;

@protocol HWEmotionTabBarDelegate <NSObject>
@optional
- (void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType;
@end

@interface HWEmotionTabBar : UIView
@property (weak,nonatomic) id<HWEmotionTabBarDelegate> delegate;
@end
