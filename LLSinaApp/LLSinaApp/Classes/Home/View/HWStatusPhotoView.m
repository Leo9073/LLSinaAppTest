//
//  HWStatusPhotoView.m
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

@interface HWStatusPhotoView ()
@property (weak,nonatomic) UIImageView *gifView;
@end

@implementation HWStatusPhotoView

- (UIImageView *)gifView {
    
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;  //超出边框被裁减
    }
    return self;
}

- (void)setPhoto:(HWPhoto *)photo {
    
    _photo = photo;
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示/隐藏gif图片
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gifView.hidden = NO;
//    } else {
//        self.gifView.hidden = YES;
//    }
    
    //判断是否以gif或者GIF结尾
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
