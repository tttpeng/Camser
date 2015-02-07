//
//  PTMyGoodsCell.h
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTGoodsList;

@protocol PTMyGoodsCellDelegate <NSObject>

@optional
- (void)deletaAndReloadTableView;
@end
@interface PTMyGoodsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)PTGoodsList *goods;
@property (nonatomic,weak )id<PTMyGoodsCellDelegate>delegate;
@end
