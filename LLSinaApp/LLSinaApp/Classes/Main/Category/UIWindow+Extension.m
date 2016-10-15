//
//  UIWindow+Extension.m
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWTabbBarViewController.h"
#import "HWNewfeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController {
    
    NSString *key = @"CFBundleVersion";
    //3、存储在沙盒中的版本号（上一次的使用版本）CFBundleVersion
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];;
    
    //3.1获得当前软件的版本号（从info.plist中获取）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { //版本号相同,这次和上次打开的为同一版本
        self.rootViewController = [[HWTabbBarViewController alloc]init];
    } else { // 3.2这次打开的版本和上次的版本不一样，显示新特性
        self.rootViewController = [[HWNewfeatureViewController alloc]init];
        //3.3将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
