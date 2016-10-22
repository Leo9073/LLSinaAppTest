//
//  HWIconView.m
//  LLSinaApp
//
//  Created by Leo on 10/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView ()
@property (weak,nonatomic) UIImageView *verfiedView;
@end

@implementation HWIconView

- (UIImageView *)verfiedView {
    
    if (!_verfiedView) {
        UIImageView *verfiedView = [[UIImageView alloc] init];
        [self addSubview:verfiedView];
        self.verfiedView = verfiedView;
    }
    return _verfiedView;
}

- (void)setUser:(HWUser *)user {
    
    _user = user;
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置加V图片
    switch (user.verified_type) {
        case HWUserVerifiedTypePersonal:
            self.verfiedView.hidden = NO;
            self.verfiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserVerifiedTypeOrgEnterprice:
        case HWUserVerifiedTypeOrgMedia:
        case HWUserVerifiedTypeOrgWebsite:
            self.verfiedView.hidden = NO;
            self.verfiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case HWUserVerifiedTypeDaren:
            self.verfiedView.hidden = NO;
            self.verfiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verfiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置加V图片尺寸和位置
    self.verfiedView.size = self.verfiedView.image.size;
    self.verfiedView.x = self.width - self.verfiedView.width*0.6;
    self.verfiedView.y = self.height - self.verfiedView.height*0.6;
}

@end
