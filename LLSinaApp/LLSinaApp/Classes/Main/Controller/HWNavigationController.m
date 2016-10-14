//
//  HWNavigationController.m
//  LLSinaApp
//
//  Created by Leo on 10/13/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWNavigationController.h"
#import "HWItemTool.h"

@interface HWNavigationController ()

@end

@implementation HWNavigationController

+ (void)initialize {
    
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disabledTextAttrs = [NSMutableDictionary dictionary];
    disabledTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabledTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disabledTextAttrs forState:UIControlStateDisabled];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  重写这个方法的目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 *  @param animated       <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //    NSLog(@"%@",viewController);
    //    NSLog(@"%lu %@",(unsigned long)self.viewControllers.count,viewController);
    
    //这时push进来的控制器，不是第一个控制器(不是根控制器)
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES; //自动显示和隐藏tabbar
        
        //设置左边返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(back) withImage:@"navigationbar_back" withHighlightedImage:@"navigationbar_back_highlighted"];
        //设置右边更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(more) withImage:@"navigationbar_more" withHighlightedImage:@"navigationbar_more_highlighted"];
    } //刚进来控制器为0，条件不成立,不会执行
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    
#warning 这里要用self，不是self.navigationController
    [self popViewControllerAnimated:YES];
}

- (void)more {
    
    [self popToRootViewControllerAnimated:YES];
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
