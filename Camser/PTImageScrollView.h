//
//  PTImageScrollView.h
//  Camser
//
//  Created by iPeta on 15/1/27.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PTImageScrollViewDelegate <NSObject>

@optional
- (void)backToDetailViewController;

@end
@interface PTImageScrollView : UIScrollView

@property (nonatomic,weak)id<UIScrollViewDelegate,PTImageScrollViewDelegate>delegate;
@property (nonatomic)int index;

+ (PTImageScrollView *)imageScrollViewWith:(UIImage *)image andFrame:(CGRect)frame;

@end
