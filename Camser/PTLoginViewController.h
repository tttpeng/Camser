//
//  PTLoginViewController.h
//  Camser
//
//  Created by iPeta on 15/1/15.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerReload;
@end

@interface PTLoginViewController : UIViewController
@property (nonatomic,weak) id<PTLoginViewControllerDelegate>delegate;
@end
