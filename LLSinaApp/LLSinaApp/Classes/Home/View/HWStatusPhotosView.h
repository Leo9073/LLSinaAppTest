//
//  HWStatusPhotosView.h
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//  cell上面的配图，可能显示1-9张图片

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView
@property (strong,nonatomic) NSArray *photos;
+ (CGSize)sizeWithCount:(NSInteger)count;
@end
