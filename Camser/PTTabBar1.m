////
////  PTTabBar.m
////  项目01-旧物交易
////
////  Created by iPeta on 14/12/30.
////  Copyright (c) 2014年 河南青云. All rights reserved.
////
//
//#import "PTTabBar.h"
//#import "PTTabBarButton.h"
//
//@interface PTTabBar()
//
//@property (nonatomic,weak) UIButton *selected;
//@end
//
//@implementation PTTabBar
//
///**
// *  确定按钮位置
// */
//-(void)layoutSubviews
//{
//    self.backgroundColor = [UIColor colorWithWhite:0.171 alpha:1.000];
//    int count = (int)self.subviews.count;
//    
//    NSLog(@"总数%d",count);
//    for (int i = 0; i < count - 1 ;i ++) {
//        PTTabBarButton *button = self.subviews[i + 1];
//        button.tag = i;
//        CGFloat buttonY = 0;
//        CGFloat buttonH = self.frame.size.height;
//        CGFloat buttonW = self.frame.size.width / 4;
//        CGFloat buttonX = buttonW * i;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//  
//        
//    }
//
//}
//
//
///**
// *  设置TabBar的背景图片
// *
// *  @param name 图片名
// */
//- (void)addBackgroundImageWithName:(NSString *)name
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = self.bounds;
//    imageView.backgroundColor = [UIColor whiteColor];
////    imageView.image = [UIImage imageNamed:name];
//    [self addSubview:imageView];
//}
//
///**
// *  设置在TabBar上添加的按钮
// */
//- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName title:(NSString *)title
//{
//    PTTabBarButton *button = [PTTabBarButton buttonWithType:UIButtonTypeCustom];
//
//    [button setImage:[UIImage imageNamed:name]forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
////    [button setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_button_highlighted"] forState:UIControlStateHighlighted];
//    [button setTitle:title forState:UIControlStateNormal];//设置button的title
//    [self addSubview:button];
//    button.adjustsImageWhenHighlighted = NO;
//    [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    if (self.subviews.count == 2) {
//        [self BtnClick:button];
//    }
//}
//
//
//- (void)BtnClick:(PTTabBarButton *)button
//{
//    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemFrom:to:)]) {
//        [self.delegate tabBar:self didSelectItemFrom:(int)self.selected.tag to:(int)button.tag];
//    }
//    self.selected.selected = NO;
//    button.selected = YES;
//    self.selected = button;
//}
//@end
