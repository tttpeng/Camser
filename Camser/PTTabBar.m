//
//  PTTabBar.m
//  Camser
//
//  Created by iPeta on 15/1/31.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTTabBar.h"
#import "PTTabBarButton.h"

@interface PTTabBar ()

@property (nonatomic,weak) UIButton *selected;

@end

@implementation PTTabBar


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.translucent = YES;
        self.barStyle = UIBarStyleDefault;
        self.tintColor = [UIColor redColor];
        self.barTintColor = [UIColor whiteColor];
        self.backgroundColor  = [UIColor clearColor];
        self.alpha = 0.8;
       
        [self setButton];
        [self setButtonFrame];
     
    }
    return self;
}



- (void)setButton
{
    [self addTabButtonWithName:@"home_icon1" selName:@"home_icon_selected" title:@"主页" ];
     [self addTabButtonWithName:@"bianji_icon" selName:@"bianji_icon_selected" title:@"发布" ];
     [self addTabButtonWithName:@"profile_icon" selName:@"profile_icon_selected" title:@"我" ];

}

/**
 *  设置TabBar的背景图片
 *
 *  @param name 图片名
 */
- (void)addBackgroundImageWithName:(NSString *)name
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.bounds;
    imageView.backgroundColor = [UIColor whiteColor];
    //    imageView.image = [UIImage imageNamed:name];
    [self addSubview:imageView];
}

/**
 *  设置在TabBar上添加的按钮
 */
- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName title:(NSString *)title
{
     PTTabBarButton *button = [PTTabBarButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:name]forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];//设置button的title
    [self addSubview:button];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
 
}

- (void)setButtonFrame
{
    for (int i = 0 ; i < 3; i ++) {
        PTTabBarButton *button = self.subviews[i + 3];
        button.frame = CGRectMake(i * 125, 0, 125, 49);
        button.tag  = i;
        
        if (i == 0) {
            button.selected = YES;
            self.selected = button;
        }
    }
}


- (void)BtnClick:(PTTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemFrom:to:)]) {
        [self.delegate tabBar:self didSelectItemFrom:(int)self.selected.tag to:(int)button.tag];
    }
    self.selected.selected = NO;
    button.selected = YES;
    self.selected = button;
}

@end
