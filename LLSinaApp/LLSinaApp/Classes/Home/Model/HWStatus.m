//
//  HWStatus.m
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWStatus.h"
#import "HWUser.h"
#import "HWPhoto.h"
#import <MJExtension.h>

@implementation HWStatus

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"pic_urls" : [HWPhoto class]};
}

@end
