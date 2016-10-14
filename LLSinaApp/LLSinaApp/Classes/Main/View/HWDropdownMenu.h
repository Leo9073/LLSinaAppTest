//
//  HWDropdownMenu.h
//  LLSinaApp
//
//  Created by Leo on 10/14/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropdownMenu;

@protocol HWDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(HWDropdownMenu *)menu;
@end

@interface HWDropdownMenu : UIView
@property (weak,nonatomic) id<HWDropdownMenuDelegate> delegate;
+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
/**
 *  内容
 */
@property (strong,nonatomic) UIView *content;
/**
 *  内容控制器
 */
@property (strong,nonatomic) UIViewController *contentController;
@end
