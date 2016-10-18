//
//  HWUser.m
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser

- (void)setMbtype:(NSInteger)mbtype {
    
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end
