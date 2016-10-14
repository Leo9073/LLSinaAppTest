//
//  HWTabBar.h
//  LLSinaApp
//
//  Created by Leo on 10/14/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;

#warning 因为HWTabBar继承自UITabBar，所有成为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end

@interface HWTabBar : UITabBar
@property (weak,nonatomic) id<HWTabBarDelegate> delegate;
@end
