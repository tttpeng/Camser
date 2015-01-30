//
//  PTTabBarController.m
//  项目01-旧物交易
//
//  Created by iPeta on 14/12/30.
//  Copyright (c) 2014年 河南青云. All rights reserved.
//

#import "PTTabBarController.h"
#import "PTTabBarButton.h"
#import "PTTabBar.h"

@interface PTTabBarController ()<PTTabBarDelegate>

@end

@implementation PTTabBarController



- (void)viewDidLoad
{
    
    PTTabBar *myTabBar = [[PTTabBar alloc]init];
    myTabBar.frame = self.tabBar.bounds;
    myTabBar.delegate = self;
    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.226 alpha:1.000];
//    [self.tabBar addSubview:myTabBar];
    
    [myTabBar addBackgroundImageWithName:@"bg_tabbar"];
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        
        NSString *title = [[NSString alloc] init];
        switch (i + 1) {
            case 1:
                title = @"首页";
                break;
            case 2:
                title = @"出售";
                break;
            case 3:
                title = @"我的";
                break;
            case 4:
                title = @"更多";
                break;
            default:
                break;
        }
        UITabBarItem *one =  self.tabBar.items[1];
        one.image = [[UIImage imageNamed:@"green-02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        one.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        UITabBarItem *two = self.tabBar.items[0];
        two.image = [[UIImage imageNamed:@"yellow-27"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        two.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        UITabBarItem *three = self.tabBar.items[2];
        three.image = [[UIImage imageNamed:@"blue-35-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        three.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tab_bar_selected"];
        NSString *normal = [NSString stringWithFormat:@"icon_tabbar_%d",i + 1];
        NSString *high = [NSString stringWithFormat:@"icon_tabbar_%d_selected",i + 1];
        [myTabBar addTabButtonWithName:normal selName:high title:title];
    }
    
    
}

- (void)tabBar:(PTTabBar *)tabBar didSelectItemFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}
@end
