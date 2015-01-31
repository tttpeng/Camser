//
//  PTNavigationController.m
//  zzti-second
//
//  Created by iPeta on 14/12/31.
//  Copyright (c) 2014年 河南青云. All rights reserved.
//

#import "PTNavigationController.h"
#import "UIImage+MJ.h"
#import "PTDetailInfoView.h"

@interface PTNavigationController()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITabBarItem *homeItem;

@end

@implementation PTNavigationController


- (void)viewDidLoad
{
    self.interactivePopGestureRecognizer.delegate = self;
}

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.backgroundColor = [UIColor whiteColor];
//    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleDefault;
    UIImage *image = [UIImage imageNamed:@"cm2_topbar_bg"];
    image = [UIImage resizedImageWithName:@"cm2_topbar_bg"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    navBar.barTintColor = [UIColor colorWithWhite:0.135 alpha:1.000];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//    navBar.hidden = YES;
    navBar.alpha = 0.2;
    [navBar setTitleTextAttributes:attrs];
    
    
    
    
    //设置导航栏按钮的样式BarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    item.tintColor = [UIColor whiteColor];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];

}
@end
