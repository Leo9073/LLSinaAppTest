//
//  HWComposePhotosView.h
//  LLSinaApp
//
//  Created by Leo on 10/24/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;

//默认会自动生成getter的声明和实现，_开头的成员变量
//如果手动实现了getter，那么久不会自动生成getter的实现和_开头的成员变量
@property (strong,nonatomic,readonly) NSMutableArray *photos;

//默认会自动生成setter和getter的声明和实现，_开头的成员变量
//如果手动实现了setter和getter，那么久不会自动生成setter和getter的实现和_开头的成员变量
//@property (strong,nonatomic) NSMutableArray *addedPhotos;

@end
