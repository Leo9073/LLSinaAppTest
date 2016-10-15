//
//  HWTabbBarViewController.m
//  LLSinaApp
//
//  Created by Leo on 10/13/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWTabbBarViewController.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"
#import "HWNavigationController.h"
#import "HWTabBar.h"

@interface HWTabbBarViewController () <HWTabBarDelegate>

@end

@implementation HWTabbBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc]init];
    [self addChildVc:home WithTitle:@"首页" withImage:@"tabbar_home" withSelectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterViewController *messageCenter = [[HWMessageCenterViewController alloc]init];
    [self addChildVc:messageCenter WithTitle:@"消息" withImage:@"tabbar_message_center" withSelectedImage:@"tabbar_message_center_selected"];
    
    HWDiscoverViewController *discover = [[HWDiscoverViewController alloc]init];;
    [self addChildVc:discover WithTitle:@"发现" withImage:@"tabbar_discover" withSelectedImage:@"tabbar_discover_selected"];
    
    HWProfileViewController *profile = [[HWProfileViewController alloc]init];
    [self addChildVc:profile WithTitle:@"我" withImage:@"tabbar_profile" withSelectedImage:@"tabbar_profile_selected"];
    
    //更换系统自带tabbar
//    self.tabBar = [[HWTabBar alloc] init];
    //使用KVC
    HWTabBar *tabBar = [[HWTabBar alloc] init];
//    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    HWLog(@"%@",self.tabBar.subviews);
//    NSUInteger count = self.tabBar.subviews.count;
//    for (int i = 0; i < count; i++) {
//        UIView *child = self.tabBar.subviews[i];
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
////            HWLog(@"系统自带按钮");
//            child.width = self.tabBar.width/count;
//        }
//    }
}


//抽取重复代码到一个方法中：相同的代码放到方法中，不同的当作参数传递

/**
 *  抽取方法
 *
 *  @param childVc       控制器
 *  @param title         导航栏标题
 *  @param image         不选中图片
 *  @param selectedImage 选中图片
 */
- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title withImage:(NSString *)image withSelectedImage:(NSString *)selectedImage {
    
    //设置子控制器的文字和图片
//    childVc.tabBarItem.title = title; //设置tabbar文字
//    childVc.navigationItem.title = title; //设置navigationbar文字
    childVc.title = title; //同时设置tabbar和navigationbar的文字
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HWColor(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    //设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.view.backgroundColor = HMRandomColor;
    
    //添加导航控制器
    HWNavigationController *nav = [[HWNavigationController alloc]initWithRootViewController:childVc];
    //添加为子控制器
    [self addChildViewController:nav];
}


#pragma mark -- HWTabBarDelegate代理方法

- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar {
    
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = HWRandomColor;
    [self presentViewController:VC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
