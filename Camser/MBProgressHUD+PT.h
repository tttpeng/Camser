//
//  MBProgressHUD+PT.h
//
//  Created by iPeta on 15/1/15.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (PT)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
