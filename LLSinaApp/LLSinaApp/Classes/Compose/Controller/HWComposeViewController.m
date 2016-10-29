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
#import "HWComposePhotosView.h"
#import <SVProgressHUD.h>
#import "HWEmotionKeyboard.h"

@interface HWComposeViewController () <UITextViewDelegate,HWComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入控件 */
@property (weak,nonatomic) UITextView *textView;
/** 键盘顶部工具条 */
@property (weak,nonatomic) HWComposeToolbar *toolbar;
/** 相册(存放拍照或者相册中选择的图片) */
@property (weak,nonatomic) HWComposePhotosView *photosView;
/** 表情键盘 */
@property (strong,nonatomic) HWEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (assign,nonatomic) BOOL switchingKeyboard;
@end

@implementation HWComposeViewController

#pragma mark -- 懒加载

- (HWEmotionKeyboard *)emotionKeyboard {
    
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HWEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 258;
    }
    return _emotionKeyboard;
}


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
    
    //设置工具条
    [self setupPhotosView];
    
}

/**
 *  移除监听
 */
- (void)dealloc {
    
    [HWNotificationCenter removeObserver:self];
}

#pragma mark -- 初始化方法

/**
 *  添加相册图片
 */
- (void)setupPhotosView {
    
    HWComposePhotosView *photosView = [[HWComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height; //可以随便写
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  设置工具条
 */
- (void)setupToolbar {
    
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
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
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    //成为第一响应者（能输入文本的空间一旦成为第一响应者，就会叫出相应的键盘）
    [textView becomeFirstResponder];
    
    //监听文字改变通知
    [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //监听键盘通知
    [HWNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
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

/**
 *  键盘的frame发生改变时调用
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    /**
     键盘弹出\隐藏动画的执行节奏(先快后慢，匀速)
     UIKeyboardAnimationCurveUserInfoKey = 7;
     键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     */
    
    if (self.switchingKeyboard) return;
    NSDictionary *userinfo = notification.userInfo;
    //动画持续时间
    double duration = [userinfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userinfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //设置动画
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) { //键盘的Y值已经远远超过控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    
    if (self.photosView.photos.count) {
        
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
}

/**
 *  发布有图片的微博
 */
- (void)sendWithImage {
    
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    NSString *strUrl = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    [manager POST:strUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
    //发送成功控制器消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发布没有图片的微博
 */
- (void)sendWithoutImage {
    
    //1.请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    NSString *strUrl = @"https://api.weibo.com/2/statuses/update.json";
    
    //3.发送请求
    [manager POST:strUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
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

#pragma mark -- UITextViewDelegate代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

#pragma mark -- HWComposeToolbarDelegate代理方法

- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType {
    
    switch (buttonType) {
        case HWComposeToolbarButtonTypeCamera: //拍照
            [self openCamera];
            break;
        case HWComposeToolbarButtonTypePicture: //相册
            [self openAlbum];
            break;
        case HWComposeToolbarButtonTypeMention: //@
            
            break;
        case HWComposeToolbarButtonTypeTrend: //#
            
            break;
        case HWComposeToolbarButtonTypeEmotion: //表情
            [self switchKeyboard];
            break;
            
        default:
            break;
    }
}

#pragma mark -- 其他方法

/**
 *  切换键盘
 */
- (void)switchKeyboard {
    
    //self.textView.inputView = nil 说明使用的是系统自带键盘
    if (self.textView.inputView == nil) {  //切换为自定义键盘
        self.textView.inputView = self.emotionKeyboard;
        
        //显示键盘图标
        self.toolbar.showKeyboardButton = YES;
    } else {  //切换为系统键盘
        self.textView.inputView = nil;
        //显示表情图标
        self.toolbar.showKeyboardButton = NO;
    }
    
    //开始切换键盘
    self.switchingKeyboard = YES;
    
    //键盘退出
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
    });
    
    //结束切换
    self.switchingKeyboard = NO;
}


/**
 *  打开相机
 */
- (void)openCamera {
    
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  打开相册
 */
- (void)openAlbum {
    
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    //设置要选择的是相机还是相册
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate代理方法
/**
 *  从UIImagePickerController选择完图片后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photosView中
    [self.photosView addPhoto:image];
    
    
}

@end
