//
//  HWDropdownMenu.m
//  LLSinaApp
//
//  Created by Leo on 10/14/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWDropdownMenu.h"

@interface HWDropdownMenu ()
/**
 *  将来用来显示具体内容的容器
 */
@property (weak,nonatomic) UIImageView *containerView;
@end

@implementation HWDropdownMenu

/**
 *  懒加载
 *
 *  @return contentView
 */
- (UIImageView *)containerView {
    
    if (!_containerView) {
        //添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //清除颜色
        self.backgroundColor = [UIColor clearColor];
}
    return self;
}

+ (instancetype)menu {
    
    return [[self alloc] init];
}


- (void)setContent:(UIView *)content {
    
    _content = content;
    
    //调整内容的位置
    content.x = 10;
    content.y = 15;
    
    //调整内容的宽度
//    content.width = self.containerView.width - content.x * 2;
    
    //设置灰色图片的宽度
    self.containerView.width = CGRectGetMaxX(content.frame)+10;
    
    //设置灰色图片的高度
    self.containerView.height = CGRectGetMaxY(content.frame)+11;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController {
    
    _contentController = contentController;
    self.content = contentController.view;
}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from {
    
    //获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加自己到窗口上
    [window addSubview:self];
    
    //设置尺寸
    self.frame = window.bounds;
    
    //调整灰色图片的位置
    //默认情况下，frame是以父控件左上角为坐标原点
    //可以转换坐标系原点，改变frame的参照点
//    CGRect newFrame = [from convertRect:from.bounds toView:window]; //与上面的写法是一样的效果，将自身的坐标原点转换为窗口的坐标原点进行计算
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    //通知代理，自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

/**
 *  销毁
 */
- (void)dismiss {
    
    [self removeFromSuperview];
    
    //通知外界，自己被销毁了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
}

@end
