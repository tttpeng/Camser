//
//  PTCommentCell.h
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTCommentFrame;
@interface PTCommentCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)PTCommentFrame *commentFrame;


@end
