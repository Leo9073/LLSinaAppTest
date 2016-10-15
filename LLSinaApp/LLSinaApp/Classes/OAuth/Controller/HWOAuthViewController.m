//
//  HWOAuthViewController.m
//  LLSinaApp
//
//  Created by Leo on 16/10/15.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWTabbBarViewController.h"
#import "HWNewfeatureViewController.h"
#import "HWAccount.h"
#import "HWAccountTool.h"

@interface HWOAuthViewController () <UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //用webView加载登录页面(新浪提供)
    //请求地址：https://api.weibo.com/oauth2/authorize
    /*
     请求参数：
     client_id:申请应用时分配的AppKey:
     redirect_uri:授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     App Key：4205302763
     App Secret：41c3221ee56f175a6748410db2d8c224
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4205302763&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //获得URL
    NSString *url = request.URL.absoluteString;
    //判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { //是回调地址
        //截取code=后面的参数值
        NSInteger fromIndex = range.location+range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        //利用code换取accessToken
        [self accessTokenWithCode:code];
        
        ////禁止加载回调地址
        return NO;
    }
    return YES;
}

/**
 *  利用code(授权过的request token)，换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code {
    
    //请求地址：https://api.weibo.com/oauth2/access_token
    /*
     请求参数：
     client_id:申请应用时分配的AppKey。
     client_secret:应用时分配的AppSecret。
     grant_type	true:请求的类型，填写authorization_code
     code	true:调用authorize获得的code值。
     redirect_uri:回调地址，需需与注册应用里的回调地址一致。
     App Key：4205302763
     App Secret：41c3221ee56f175a6748410db2d8c224
     */
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"4205302763";
    params[@"client_secret"] = @"41c3221ee56f175a6748410db2d8c224";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    NSString *strUrl = @"https://api.weibo.com/oauth2/access_token";
    
    //3.发送请求
    [manager POST:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //将返回的账号字典数据存进沙盒
        HWAccount *account = [HWAccount accountWithDic:responseObject];
        //存储账号信息
        [HWAccountTool saveAccount:account];
        
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HWLog(@"请求失败---->%@",error);
    }];
    
    /*
     "access_token" = "2.006lgtCCv2BbaE68a425e1896s8EYE";
     "expires_in" = 157679999; //5年有效期
     "remind_in" = 157679999;
     uid = 1875090763
     */
}

@end
