//
//  PTRegisterViewController.m
//  Camser
//
//  Created by iPeta on 15/1/15.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTRegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>

@interface PTRegisterViewController ()
- (IBAction)backBtn:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *accountName;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)RegisterBtn:(UIButton *)sender;

@end

@implementation PTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)RegisterBtn:(UIButton *)sender {

    
  [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"219407974" andAppSecret:@"fd66f84d94d6a7945d7873268fc73d84" andRedirectURI:@"https://api.weibo.com/oauth2/default.html"];
    
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {

    } toPlatform:AVOSCloudSNSSinaWeibo];

    
    
//    AVUser * user = [AVUser user];
//    user.username = self.accountName.text;
//    user.password = self.password.text;
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            
//        } else {
//            
//        }
//    }];
}
@end
