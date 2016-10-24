//
//  HWComposeToolbar.h
//  LLSinaApp
//
//  Created by Leo on 10/23/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolbarButtonTypeCamera, //拍照
    HWComposeToolbarButtonTypePicture, //相册
    HWComposeToolbarButtonTypeMention, //@
    HWComposeToolbarButtonTypeTrend, //#
    HWComposeToolbarButtonTypeEmotion //表情
} HWComposeToolbarButtonType;

@class HWComposeToolbar;

@protocol HWComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType;
@end

@interface HWComposeToolbar : UIView
@property (weak,nonatomic) id<HWComposeToolbarDelegate> delegate;
@end
