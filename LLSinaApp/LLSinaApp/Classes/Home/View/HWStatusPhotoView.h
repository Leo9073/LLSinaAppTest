//
//  HWStatusPhotoView.h
//  LLSinaApp
//
//  Created by Leo on 10/20/16.
//  Copyright © 2016 Leo. All rights reserved.
//  cell上面的配图相册GIF

#import <UIKit/UIKit.h>
@class HWPhoto;

@interface HWStatusPhotoView : UIImageView
@property (strong,nonatomic) HWPhoto *photo;
@end
