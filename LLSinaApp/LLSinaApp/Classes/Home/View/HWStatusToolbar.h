//
//  HWStatusToolbar.h
//  LLSinaApp
//
//  Created by Leo on 10/19/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWStatus.h"

@interface HWStatusToolbar : UIView
+ (instancetype)toolbar;
@property (strong,nonatomic) HWStatus *status;
@end
