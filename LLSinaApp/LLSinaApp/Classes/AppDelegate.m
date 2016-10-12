//
//  AppDelegate.m
//  LLSinaApp
//
//  Created by Leo on 10/12/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "AppDelegate.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1、创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //2、设置导航栏控制器
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    self.window.rootViewController = tabBarVC;
    
    //3、设置子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc]init];
    [self addChildVc:home WithTitle:@"首页" withImage:@"tabbar_home" withSelectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterViewController *messageCenter = [[HWMessageCenterViewController alloc]init];
    [self addChildVc:messageCenter WithTitle:@"消息" withImage:@"tabbar_message_center" withSelectedImage:@"tabbar_message_center_selected"];
    
    HWDiscoverViewController *discover = [[HWDiscoverViewController alloc]init];;
    [self addChildVc:discover WithTitle:@"发现" withImage:@"tabbar_discover" withSelectedImage:@"tabbar_discover_selected"];
    
    HWProfileViewController *profile = [[HWProfileViewController alloc]init];
    [self addChildVc:profile WithTitle:@"我" withImage:@"tabbar_profile" withSelectedImage:@"tabbar_profile_selected"];
    [tabBarVC addChildViewController:home];
    [tabBarVC addChildViewController:messageCenter];
    [tabBarVC addChildViewController:discover];
    [tabBarVC addChildViewController:profile];
    //4、显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


//抽取重复代码到一个方法中：相同的代码放到方法中，不同的当作参数传递
- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title withImage:(NSString *)image withSelectedImage:(NSString *)selectedImage {
    
    //设置子控制器的文字和图片
    childVc.tabBarItem.title = title;
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HMColor(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.view.backgroundColor = HMRandomColor;
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
