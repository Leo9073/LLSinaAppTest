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
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWStatus.h"
#import <MJExtension.h>
#import "HWLoadMoreFooter.h"
#import "HWStatusCell.h"
#import "HWStatusFrame.h"

@interface HWHomeViewController () <HWDropdownMenuDelegate>
/**
 *  微博数组(里面放的都是模型，一个字典代表一条微博)
 */
@property (strong,nonatomic) NSMutableArray *statusFrames;
@end

@implementation HWHomeViewController

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HWColor(211, 211, 211);
    //设置导航栏标题
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
    //获得当前用户及所关注的人的微博数据
//    [self loadNewStatus];
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];
    
    //获得未读微博数量
    //开启一个定时器，间隔一段时间获取最新未读的微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    NSString *strUrl = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    
    // 3.发送请求
    [manager GET:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //description将NSNumber转成字符串
        NSString *status = [responseObject[@"status"] description];
        
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            //也清空程序图标上的数字
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败---->%@",error);
    }];
}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh {
    
    HWLoadMoreFooter *footer = [HWLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh {
    
    //添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
    //只有用户手动下拉刷新才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //进入刷新状态(仅仅是显示刷新状态，不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    //马上加载数据
    [self loadNewStatus:control];
}

/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)statusFrameWithStatuses:(NSArray *)statuses {
    
    NSMutableArray *frames = [NSMutableArray array];
    for (HWStatus *status in statuses) {
        HWStatusFrame *f = [[HWStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 *  UIRefreshControl进入刷新状态，加载最新数据(最前面的数据)
 */
- (void)loadNewStatus:(UIRefreshControl *)control {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出最前面的微博(最新的微博，ID最大的微博)
    HWStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    NSString *strUrl = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    //3.发送请求
    [manager GET:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
//        HWLog(@"%@",responseObject);
        //取得微博数组
        NSArray *newStatuses = [HWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将HWStatus数组转为HWStatusFrame数组
        NSArray *newFrames = [self statusFrameWithStatuses:newStatuses];
        
        //将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败---->%@",error);
        //结束刷新
        [control endRefreshing];
    }];
}

/**
 *  加载更多的微博数据（加载以前的，从最下面加载）
 */
- (void)loadMoreStatus {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出最后面的微博(最新的微博，ID最大的微博)
    HWStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        //若指定次参数，则返回ID小于或等于max_id的微博，默认为0
        //id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxID = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxID);
    }
    NSString *strUrl = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    //3.发送请求
    [manager GET:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //取得微博数组
        NSArray *newStatuses = [HWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将HWStatus数组转为HWStatusFrame数组
        NSArray *newFrames = [self statusFrameWithStatuses:newStatuses];
        
        //将最新的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新,隐藏footer
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败---->%@",error);
        
        //结束刷新,隐藏footer
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  显示最新微博数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(NSInteger)count {
    
    //如果刷新成功，清空图片数字
    self.tabBarItem.badgeValue = nil;
    //如果刷新成功，也清空程序图标上的数字
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.height = 35;
    label.width = [UIScreen mainScreen].bounds.size.width;
    
    //设置其他属性
    if (count == 0) {
        label.text = @"没有最新微博";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条最新微博",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //添加label
    label.y = 64 - label.height;
    //将label添加到导航控制器中，并且在盖在导航栏下边，即navigationBar下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    //先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; //动画时间
    [UIView animateWithDuration:duration animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; //延迟1s
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity; //回到初始位置
        } completion:^(BOOL finished) {
            [label removeFromSuperview]; //从父视图中移除
        }];
    }];
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
        //设置名字
        HWUser *user = [HWUser mj_objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        account.name = user.name;
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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(friendSearch) withImage:@"navigationbar_friendsearch" withHighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    //设置右边更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(pop) withImage:@"navigationbar_pop" withHighlightedImage:@"navigationbar_pop_highlighted"];
    
    //设置中间item标题按钮
    HWTitleButton *titleButton = [[HWTitleButton alloc] init];
    
/** 测试用
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
*/
 
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

- (void)friendSearch {
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获得cell
    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //scrollView == self.tableView == self.view
    //如果tableView还么有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        //显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        //同时加载更多的数据
        [self loadMoreStatus];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
    
}


/**
 1、将字典转为模型
 2、能够下拉刷新最新的微博数据
 3、能够上拉加载更多的微博数据
 */


@end
