//
//  HWComposeViewController.m
//  LLSinaApp
//
//  Created by Leo on 10/23/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWTextView.h"
#import "AFNetworking.h"
#import "HWComposeToolbar.h"

@interface HWComposeViewController ()
@property (weak,nonatomic) UITextView *textView;
@end

@implementation HWComposeViewController

#pragma mark -- 系统方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏
    [self setupNav];
    
    //设置输入控件
    [self setupTextView];
    
    //设置工具条
    [self setupToolbar];
}

/**
 *  移除监听
 */
- (void)dealloc {
    
    [HWNotificationCenter removeObserver:self];
}

#pragma mark -- 初始化方法

/**
 *  设置工具条
 */
- (void)setupToolbar {
    
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc] init];
    toolbar.width = self.view.bounds.size.width;
    toolbar.height = 44;
    self.textView.inputAccessoryView = toolbar;
}

/**
 *  设置输入控件
 */
- (void)setupTextView {
    
    HWTextView *textView = [[HWTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    //监听通知
    [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

/**
 *  设置导航栏
 */
- (void)setupNav {
    
    //设置左右导航栏的标题
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //设置中间发微博标题
    NSString *name = [HWAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 100;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        self.navigationItem.titleView = titleView;
        
        //设置换行属性
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        //创建一个带有属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
    } else {
        self.title = prefix;
    }
}

#pragma mark -- 监听方法
- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    
    // URL:https://api.weibo.com/2/statuses/update.json
    // access_token:采用OAuth授权方式为必填参数，OAuth授权后获得。(true)
    // status:发布的微博文本内容，必须做URLencode，内容不超过140个汉字。(true)
    // pic:要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。(二进制数据)(false)
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    NSString *strUrl = @"https://api.weibo.com/2/statuses/update.json";
    
    //3.发送请求
    [manager POST:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HWLog(@"请求失败---->%@",error);
    }];
    
    //发送成功控制器消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


@end
