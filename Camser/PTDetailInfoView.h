//
//  PTDetailInfoView.h
//  Camser
//
//  Created by iPeta on 15/1/26.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTGoodsList;
@protocol PTDetailInfoViewDelegate <NSObject>

- (void)skip2bigViewController:(UIViewController *)viewController;

@end
@interface PTDetailInfoView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;

@property (nonatomic, strong) PTGoodsList *goods;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic ,weak)id<PTDetailInfoViewDelegate>delegate;

+ (instancetype)detailInfoView;
+ (instancetype)detailInfoViewWithGoods:(PTGoodsList *)goods;
@end
