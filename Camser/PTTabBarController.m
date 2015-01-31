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
#import "UIImage+MJ.h"
#import <JCRBlurView.h>

@interface PTTabBarController ()<PTTabBarDelegate>
@property (nonatomic,weak) UIButton *selected;
@end

@implementation PTTabBarController



- (void)viewDidLoad
{


    
    
}





- (void)tabBar:(PTTabBar *)tabBar didSelectItemFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}
@end
