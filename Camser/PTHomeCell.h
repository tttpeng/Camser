//
//  PTHomeCell.h
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTCellItem;
@interface PTHomeCell : UITableViewCell

@property (nonatomic,strong)PTCellItem *item;
+ (instancetype)headCellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
