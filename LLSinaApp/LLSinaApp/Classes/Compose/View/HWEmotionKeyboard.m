//
//  HWEmotionKeyboard.m
//  LLSinaApp
//
//  Created by Leo on 10/29/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabBar.h"

@interface HWEmotionKeyboard () <HWEmotionTabBarDelegate>
@property (weak,nonatomic) HWEmotionListView *listView;
@property (weak,nonatomic) HWEmotionTabBar *tabBar;
@end

@implementation HWEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //表情内容
        HWEmotionListView *listView = [[HWEmotionListView alloc] init];
//        listView.backgroundColor = HWRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        //tabbar
        HWEmotionTabBar *tabBar = [[HWEmotionTabBar alloc] init];
//        tabBar.backgroundColor = HWRandomColor;
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //tabbar
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    
    //listView
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}


#pragma mark -- HWEmotionTabBarDelegate
- (void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType {
    
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeRecent:
            
            break;
        case HWEmotionTabBarButtonTypeDefault:
            
            break;

        case HWEmotionTabBarButtonTypeEmoji:
            
            break;

        case HWEmotionTabBarButtonTypeLxh:
            
            break;
            
        default:
            break;
    }
}

@end
