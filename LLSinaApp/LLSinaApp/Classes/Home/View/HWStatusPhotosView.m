//
//  HWStatusPhotosView.m
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "HWStatusPhotoView.h"

#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 5
#define HWStatusPhotoMaxCol(count) ((count == 4) ? 2:3)

@implementation HWStatusPhotosView

- (void)setPhotos:(NSArray *)photos {
    
    _photos = photos;
    NSInteger photosCount = photos.count;
    
    //self.subviews.count不能单独赋值给其他变量
    
    //创建足够数量的imageView
    while (self.subviews.count < photosCount) {
        HWStatusPhotoView *photoView = [[HWStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    //遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {            //显示图片
            photoView.hidden = NO;
            photoView.photo = photos[i];
        } else {            //隐藏图片
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    NSInteger photosCount = self.photos.count;
    NSInteger maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        NSInteger col = i % maxCol;
        photoView.x = col * (HWStatusPhotoWH+HWStatusPhotoMargin);
        
        NSInteger row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH+HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}

/**
 *  根据图片个数计算相册宽度和高度
 */
+ (CGSize)sizeWithCount:(NSInteger)count {
    
    NSInteger maxCols = HWStatusPhotoMaxCol(count);
    // 列数
    NSInteger cols = (count >= maxCols)? maxCols:count;
    CGFloat photosW = cols*HWStatusPhotoWH + (cols-1)*HWStatusPhotoMargin;
    
    //    NSInteger rows = 0;
    //    if (count % 3 == 0) { //count = 3/6/9
    //        rows = count/3;
    //    } else {
    //        rows = count / 3 +1;
    //    }
    
    //    NSInteger rows = count/3;
    //    if (count % 3 != 0) { //count = 3/6/9
    //        rows += 1;
    //    }
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows*HWStatusPhotoWH + (rows-1)*HWStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
}


@end
