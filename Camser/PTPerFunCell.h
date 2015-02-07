//
//  PTPerFunCell.h
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTPerFunCellDelegate <NSObject>

- (void)homeSkip2myGoodsOrFavorite:(int)index;


@end

@interface PTPerFunCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,weak)id<PTPerFunCellDelegate>delegate;

@property (nonatomic,strong)NSDictionary *countDict;
@end
