//
//  PTTabBar.h
//  Camser
//
//  Created by iPeta on 15/1/31.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTTabBar;
@protocol PTTabBarDelegate <NSObject>

@optional
- (void)tabBar:(PTTabBar *)tabBar didSelectItemFrom:(int)from to:(int)to;

@end

@interface PTTabBar : UITabBar
@property (nonatomic,weak) id<PTTabBarDelegate> delegate;
- (void)addBackgroundImageWithName:(NSString *)name;
- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName title:(NSString *)title;
@end
