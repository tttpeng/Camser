//
//  PTHomeViewController.m
//  Camser
//
//  Created by iPeta on 15/1/15.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTHomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "PTSettingGroup.h"
#import "PTPerSettingViewController.h"
#import "PTHeadCellItem.h"
#import "PTHomeCell.h"
#import "PTLoginViewController.h"
#import "PTNavigationController.h"
#import "MBProgressHUD+PT.h"

@interface PTHomeViewController ()<PTLoginViewControllerDelegate,PTPerSettingViewControllerDelegate>


@end

@implementation PTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGroup0];
}
- (void)setGroup0
{
    PTHeadCellItem *item0;
    AVUser *current = [AVUser currentUser];
    
    
    if (current) {
        NSString *title = [current objectForKey:@"nickName"];
        AVFile *applicantResume = [current objectForKey:@"imageFile"];
        NSData *resumeData = [applicantResume getData];
        item0 = [PTHeadCellItem itemWithIcon:resumeData title:title backIamge:@"bg_account_head_new" destVcClass:[PTPerSettingViewController class]];
    }else
    {
        
        item0 = [PTHeadCellItem itemWithIcon:nil title:@"点击登录" backIamge:@"bg_account_head_new" destVcClass:[PTPerSettingViewController class]];
    }
    PTSettingGroup *group0 = [[PTSettingGroup alloc] init];
    group0.items = @[item0];
    [self.data removeAllObjects];
    [self.data addObject:group0];
}
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
        
    }
    return _data;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 150;
        }else{
            return 80;
        }
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PTSettingGroup *group = self.data[section];
    return group.items.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTHomeCell *cell = [PTHomeCell cellWithTableView:tableView];
    
    PTSettingGroup *group = self.data[indexPath.section];
    
    PTHeadCellItem *homeitem = group.items[indexPath.row];
    cell.item = homeitem;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTSettingGroup *group = self.data[indexPath.section];
    PTCellItem *item = group.items[indexPath.row];
    PTHeadCellItem *arrowItem = (PTHeadCellItem *)item;
    
    if (arrowItem.destVcClass == nil) return;
    
    UIViewController *vc = [[arrowItem.destVcClass alloc] init];
    vc.title = arrowItem.title;
    if ([AVUser currentUser]) {
        
        [self performSegueWithIdentifier:@"home2persetting" sender:nil];
    }else
    {
        [self performSegueWithIdentifier:@"home2login" sender:nil];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"qwewq");
    }
}


- (void)loginViewControllerReload
{
    [self setGroup0];
    [self.tableView reloadData];
}
- (void)perSettingViewControllerReload
{
    [self setGroup0];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    id nvc =segue.destinationViewController;
    if ([nvc isKindOfClass:[PTNavigationController class]]) {
        PTNavigationController *addVc = nvc;
        PTLoginViewController *vc = addVc.viewControllers[0];
        vc.delegate = self;
    }else
    {
        PTPerSettingViewController *perVc = nvc;
        perVc.delegate = self;
    }
    
}
@end
