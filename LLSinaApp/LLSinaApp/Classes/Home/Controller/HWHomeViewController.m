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

@interface HWHomeViewController () <HWDropdownMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置左边返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(friendsearch) withImage:@"navigationbar_friendsearch" withHighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    //设置右边更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self withAction:@selector(pop) withImage:@"navigationbar_pop" withHighlightedImage:@"navigationbar_pop_highlighted"];
    
    //设置中间item标题按钮
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.height = 30;
    titleButton.width = 100;
    
    //设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    //监听标题的点击
    [titleButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

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

//方法重构,避免重复代码太多
/**
 *  创建一个item
 *
 *  @param action           点击item后调用的方法
 *  @param image            图片
 *  @param highlightedImage 高亮图片
 *
 *  @return 创建完的item
 */
//- (UIBarButtonItem *)itemWithAction:(SEL)action withImage:(NSString *)image withHighlightedImage:(NSString *)highlightedImage {
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
//    //设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
//}


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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
