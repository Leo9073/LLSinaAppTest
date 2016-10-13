//
//  HWTest1ViewController.m
//  LLSinaApp
//
//  Created by Leo on 10/13/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "HWTest1ViewController.h"
#import "HWTest2ViewController.h"

@interface HWTest1ViewController ()

@end

@implementation HWTest1ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HWTest2ViewController *test2 = [[HWTest2ViewController alloc]init];
    test2.title = @"控制器2";
    [self.navigationController pushViewController:test2 animated:YES];
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
