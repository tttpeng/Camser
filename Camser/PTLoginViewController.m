//
//  PTLoginViewController.m
//  Camser
//
//  Created by iPeta on 15/1/15.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTLoginViewController.h"
#import "PTHomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+PT.h"

@interface PTLoginViewController ()<MBProgressHUDDelegate>
- (IBAction)dismissBtn:(UIBarButtonItem *)sender;
- (IBAction)loginWithQQ;

@end

@implementation PTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




- (IBAction)dismissBtn:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)loginWithQQ {
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"1104071211" andAppSecret:@"1rAOn8vBo6iVaBZ6" andRedirectURI:nil];
    UIViewController *vc = [AVOSCloudSNS loginManualyWithCallback:^(id object, NSError *error) {
        if (object) {
            
            [MBProgressHUD showMessage:@"正在登陆" toView:self.navigationController.view];
            [AVUser loginWithAuthData:object block:^(AVUser *user, NSError *error) {
                BOOL isNotOne = [user objectForKey:@"isNotOne"];
                if (!isNotOne) {
                    NSDictionary *dict = [[NSDictionary alloc] init];
                    dict = [AVOSCloudSNS userInfo:AVOSCloudSNSQQ];
                    NSString *name = dict[@"username"];
                    NSString *userId = dict[@"id"];
                    user.username  = userId;
                    [user setObject:name forKey:@"nickName"];
                    [user setObject:@(1) forKey:@"isNotOne"];
                    NSString *imageName = dict[@"avatar"];
                    
                    NSURL *url = [NSURL URLWithString:imageName];
                    NSURLSession *imageSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                    NSURLSessionTask *dataTask = [imageSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        AVFile *imageFile = [AVFile fileWithName:@"icon" data:data];
                        [imageFile save];
                        [user setObject:imageFile forKey:@"imageFile"];
                        [user save];
                        [self.delegate loginViewControllerReload];
                        [MBProgressHUD hideHUDForView:self.navigationController.view];
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                    }];
                    
                    [dataTask resume];
                    
                }else
                {   [MBProgressHUD showMessage:@"正在登陆" toView:self.navigationController.view];
                    [self.delegate loginViewControllerReload];
                    [MBProgressHUD hideHUDForView:self.navigationController.view];
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];
                }
            }];
        }
    } toPlatform:AVOSCloudSNSQQ];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }

    
    
}

///asdasdas
- (IBAction)ceshi:(id)sender {
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"219407974" andAppSecret:@"fd66f84d94d6a7945d7873268fc73d84" andRedirectURI:@"https://api.weibo.com/oauth2/default.html"];
    UIViewController *vc = [AVOSCloudSNS loginManualyWithCallback:^(id object, NSError *error) {
        if (object) {
            
            [MBProgressHUD showMessage:@"正在登陆" toView:self.navigationController.view];
            [AVUser loginWithAuthData:object block:^(AVUser *user, NSError *error) {
                BOOL isNotOne = [user objectForKey:@"isNotOne"];
                if (!isNotOne) {
                    NSDictionary *dict = [[NSDictionary alloc] init];
                    dict = [AVOSCloudSNS userInfo:AVOSCloudSNSSinaWeibo];
                    NSString *name = dict[@"username"];
                    NSString *userId = dict[@"id"];
                    user.username  = userId;
                    [user setObject:name forKey:@"nickName"];
                    [user setObject:@(1) forKey:@"isNotOne"];
                    NSString *imageName = dict[@"avatar"];
                    
                    NSURL *url = [NSURL URLWithString:imageName];
                    NSURLSession *imageSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                    NSURLSessionTask *dataTask = [imageSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        AVFile *imageFile = [AVFile fileWithName:@"icon" data:data];
                        [imageFile save];
                        [user setObject:imageFile forKey:@"imageFile"];
                        [user save];
                        [self.delegate loginViewControllerReload];
                        [MBProgressHUD hideHUDForView:self.navigationController.view];
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                    }];
                    
                    [dataTask resume];
                    
                }else
                {   [MBProgressHUD showMessage:@"正在登陆" toView:self.navigationController.view];
                    [self.delegate loginViewControllerReload];
                    [MBProgressHUD hideHUDForView:self.navigationController.view];
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];
                }
            }];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];
    if (vc) {
            [self.navigationController pushViewController:vc animated:YES];
    }
    
}





@end
