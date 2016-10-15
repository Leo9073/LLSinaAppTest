//
//  HWHomeViewController.m
//  LLSinaApp
//
//  Created by Leo on 10/12/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropdownMenu.h"
#import "HWTitleMenuViewController.h"
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWTitleButton.h"

@interface HWHomeViewController () <HWDropdownMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
}

/**
 *  获取用户信息
 *
 */
- (void)setupUserInfo {
    
    //请求路径：https://api.weibo.com/2/users/show.json
    //请求参数：access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    //uid	false	int64	需要查询的用户ID。
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    NSString *strUrl = @"https://api.weibo.com/2/users/show.json";
    
    //3.发送请求
    [manager GET:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        NSString *name = responseObject[@"name"];
        [titleButton setTitle:name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        account.name = name;
        [HWAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败---->%@",error);
    }];
}

/**
 *  设置导航栏标题
 *
 */
- (void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(friendsearch) withImage:@"navigationbar_friendsearch" withHighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    //设置右边更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(pop) withImage:@"navigationbar_pop" withHighlightedImage:@"navigationbar_pop_highlighted"];
    
    //设置中间item标题按钮
    HWTitleButton *titleButton = [[HWTitleButton alloc] init];
    
    //设置图片和文字,如果账号昵称存在，显示上次的，否则显示首页
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];

    //监听标题的点击
    [titleButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    //如果按钮内部的图片、文字固定，用imageEdgeInsets和titleEdgeInsets这两个属性来设置间距比较简单
}

/**
 *  标题点击
 *
 */
- (void)titleClicked:(UIButton *)titleButton {
    
    //创建下拉菜单
    HWDropdownMenu *menu = [HWDropdownMenu menu];
    menu.delegate = self;
    //设置内容
    HWTitleMenuViewController *menuVC = [[HWTitleMenuViewController alloc] init];
    menuVC.view.height = 150;
    menuVC.view.width = 150;
    menu.contentController = menuVC;
    
    //显示
    [menu showFrom:titleButton];
}

- (void)friendsearch {
    
    NSLog(@"friendsearch");
}

- (void)pop {
    
    NSLog(@"pop");
}

#pragma mark -- HWDropdownMenuDelegate代理方法
/**
 *  下拉菜单被销毁了
 *
 */
- (void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu {
    
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //让标题箭头向下
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.selected = NO;
}

/**
 *  下拉菜单显示了
 *
 */
- (void)dropdownMenuDidShow:(HWDropdownMenu *)menu {
    
    //让标题箭头向上
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleButton.selected = YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
