//
//  HWNewfeatureViewController.m
//  LLSinaApp
//
//  Created by Leo on 10/15/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWNewfeatureViewController.h"
#import "HWTabbBarViewController.h"
#define HWNeatureCount 4

@interface HWNewfeatureViewController () <UIScrollViewDelegate>
@property (strong,nonatomic) UIPageControl *pageControl;
@end

@implementation HWNewfeatureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建一个滚动视图,显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    //添加图片到滚动视图中
    CGFloat scrollWidth = scrollView.width;
    CGFloat scrollHeight = scrollView.height;
    for (int i = 0; i < HWNeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollWidth;
        imageView.height = scrollHeight;
        imageView.x = i * scrollWidth;
        //显示图片
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        [scrollView addSubview:imageView];
        
        //如果是最后一页，往里面添加分享按钮
        if (i == HWNeatureCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //设置scrollView其他属性
    scrollView.contentSize = CGSizeMake(scrollWidth*HWNeatureCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //创建一个pageControl,分页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = HWNeatureCount;
    pageControl.centerX = scrollWidth*0.5;
    pageControl.centerY = scrollHeight-50;
    pageControl.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HWColor(189, 189, 189);
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    //pageControl可以不设置frame也可以显示
//    pageControl.height = 50;
//    pageControl.width = 100;
//    pageControl.userInteractionEnabled = NO;
}

/**
 *  设置最后一张新特性显示的分享按钮和开始微博按钮
 *
 *  @param imageView 传递的参数imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView {
    
    //开启交互
    imageView.userInteractionEnabled = YES;
    //分享给大家
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    shareButton.width = 120;
    shareButton.height = 30;
    shareButton.centerX = imageView.width*0.5;
    shareButton.centerY = imageView.height*0.6;
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareButton addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
    
    //设置开始微博按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = shareButton.centerX;
    startButton.centerY = imageView.height*0.7;
    [startButton addTarget:self action:@selector(startButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

/**
 *  选中状态取反
 *
 *  @param sharedButton 传递的参宿sharedButton
 */
- (void)shareClicked:(UIButton *)sharedButton {
    //状态取反
    sharedButton.selected = !sharedButton.isSelected;
}

/**
 *  弹出主窗口
 *
 *  @param viewController 传递的参数viewController
 */
- (void)startButtonClicked {
    
    //切换到HWTabBarController
    //切换控制器的手段：1、push；2、modal(present)；3、window的rootViewController
#warning 此处采用第三种方法最可靠，因为显示完新特性之后不再显示，因此过程不可逆，前两种方法切换控制器可逆
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HWTabbBarViewController *rootViewController = [[HWTabbBarViewController alloc] init];
    window.rootViewController = rootViewController;
}

#pragma mark -- UIScrollViewDelegate代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double page = scrollView.contentOffset.x/scrollView.width;
    //四舍五入计算出页码
    self.pageControl.currentPage = (int)(page+0.5);
}


@end
