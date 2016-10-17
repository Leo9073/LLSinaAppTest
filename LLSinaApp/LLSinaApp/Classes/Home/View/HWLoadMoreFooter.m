//
//  HWLoadMoreFooter.m
//  LLSinaApp
//
//  Created by Leo on 10/17/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter

+ (instancetype)footer {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
