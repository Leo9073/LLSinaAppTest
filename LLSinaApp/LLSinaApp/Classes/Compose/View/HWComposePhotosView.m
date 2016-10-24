//
//  HWComposePhotosView.m
//  LLSinaApp
//
//  Created by Leo on 10/24/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWComposePhotosView.h"

@implementation HWComposePhotosView

- (void)addPhoto:(UIImage *)photo {
    
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    NSInteger count = self.subviews.count;
    NSInteger maxCol = 4;
    CGFloat photoWH = 70;
    CGFloat photoMargin = 5;
    for (int i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        NSInteger col = i % maxCol;
        photoView.x = col * (photoWH+photoMargin);
        
        NSInteger row = i / maxCol;
        photoView.y = row * (photoWH+photoMargin);
        photoView.width = photoWH;
        photoView.height = photoWH;
    }
}

@end
