//
//  AppDelegate.m
//  LLSinaApp
//
//  Created by Leo on 10/12/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "AppDelegate.h"
#import "HWTabbBarViewController.h"
#import "HWNewfeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1、创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //2、设置根控制器
    
    NSString *key = @"CFBundleVersion";
    //3、存储在沙盒中的版本号（上一次的使用版本）CFBundleVersion
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];;
    
    //3.1获得当前软件的版本号（从info.plist中获取）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { //版本号相同,这次和上次打开的为同一版本
            self.window.rootViewController = [[HWTabbBarViewController alloc]init];
    } else { // 3.2这次打开的版本和上次的版本不一样，显示新特性
        self.window.rootViewController = [[HWNewfeatureViewController alloc]init];
        //3.3将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //4、显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
