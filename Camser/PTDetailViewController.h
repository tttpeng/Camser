//
//  PTDetailViewController.h
//  Camser
//
//  Created by iPeta on 15/1/26.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTGoodsList;
@class PTComment;
@interface PTDetailViewController : UIViewController

@property (nonatomic,strong) PTGoodsList* goods;
@property (nonatomic,strong) NSArray *comments;
@end
