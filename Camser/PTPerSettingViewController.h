//
//  PTPerSettingViewController.h
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTPerSettingViewControllerDelegate <NSObject>

@optional
- (void)perSettingViewControllerReload;

@end

@interface PTPerSettingViewController : UIViewController
@property (nonatomic,weak)id<PTPerSettingViewControllerDelegate>delegate;

@end
