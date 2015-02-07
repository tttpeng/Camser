//
//  PTSettingCell.h
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTCellItem;
@interface PTSettingCell : UITableViewCell

@property (nonatomic,strong)PTCellItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end