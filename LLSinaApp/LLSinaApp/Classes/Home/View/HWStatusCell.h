//
//  HWStatusCell.h
//  LLSinaApp
//
//  Created by Leo on 10/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWStatusFrame.h"

@interface HWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong,nonatomic) HWStatusFrame *statusFrame;
@end
