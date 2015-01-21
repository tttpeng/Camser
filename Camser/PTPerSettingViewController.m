//
//  PTPerSettingViewController.m
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTPerSettingViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>

@interface PTPerSettingViewController ()
- (IBAction)logout:(UIButton *)sender;

@end

@implementation PTPerSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)logout:(UIButton *)sender {
    AVUser *user = [AVUser currentUser];
    [AVUser logOut];
    if (user) {
        [AVOSCloudSNS logout:AVOSCloudSNSSinaWeibo];
        [AVOSCloudSNS logout:AVOSCloudSNSQQ];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate perSettingViewControllerReload];
}
@end
