//
//  PTGoodsListCell.h
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTGoodsList;
@interface PTGoodsListCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) PTGoodsList *goodsList;


@end
