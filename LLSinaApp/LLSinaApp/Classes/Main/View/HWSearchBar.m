//
//  HWSearchBar.m
//  LLSinaApp
//
//  Created by Leo on 10/14/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"请输入搜索内容";
        self.font = [UIFont systemFontOfSize:15];
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //设置左边的放大镜图标
        //    UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //    //通过initWithImage来创建初始化UIImageView，UIImageView的尺寸默认就等于image的尺寸
        //    UIImageView *seachIcon = [[UIImageView alloc] initWithImage:image];
        
        //通过init来创建初始化大部分控件，控件都是没有尺寸
        UIImageView *seachIcon = [[UIImageView alloc] init];
        seachIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        seachIcon.width = 25;
        seachIcon.height = 25;
        self.leftView = seachIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

+ (instancetype)searchBar {
    
    return [[self alloc] init];
}

@end
