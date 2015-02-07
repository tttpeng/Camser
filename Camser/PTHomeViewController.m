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
#import "PTSettingArrowItem.h"
#import "PTSettingCell.h"
#import "PTHomeCell.h"
#import "PTPerFunCell.h"
#import "PTLoginViewController.h"
#import "PTNavigationController.h"
#import "MBProgressHUD+PT.h"
#import "PTFeekViewController.h"

@interface PTHomeViewController ()<PTLoginViewControllerDelegate,PTPerSettingViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,PTPerFunCellDelegate>
@property (nonatomic,strong)NSMutableDictionary *CountDict;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGroup0];
    [self setGroup1];
    [self setGroup3];
}
- (void)setGroup1
{
    PTCellItem *feedBack =[PTSettingArrowItem itemWithIcon:@"cell_renzheng" title:@"学号认证" destVcClass:[PTFeekViewController class]];
    PTCellItem *authentication =[PTSettingArrowItem itemWithIcon:@"cell_clear" title:@"清除缓存" destVcClass:[PTFeekViewController class]];
    PTSettingGroup *group1 = [[PTSettingGroup alloc] init];
    group1.items = @[feedBack,authentication];
    [self.data addObject:group1];
}

- (void)setGroup3
{
    PTCellItem *about = [PTSettingArrowItem itemWithIcon:@"cell_yijian" title:@"建议与意见" destVcClass:nil];
    PTCellItem *clear = [PTSettingArrowItem itemWithIcon:@"cell_guanyu" title:@"关于我们" destVcClass:nil];
    PTSettingGroup *group3 = [[PTSettingGroup alloc] init];
    group3.items = @[about,clear];
    [self.data addObject:group3];
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
    group0.items = @[item0,item0];
    [self.data removeAllObjects];
    [self.data addObject:group0];
}
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
//        [self setDataCount];
        
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
    return group.items.count ;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTSettingGroup *group = self.data[indexPath.section];
    PTHeadCellItem *homeitem = group.items[indexPath.row];
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            
            PTHomeCell *cell = [PTHomeCell cellWithTableView:tableView];
            cell.item = homeitem;
            return cell;
            
        }else if (indexPath.row == 1)
        {
        PTPerFunCell *cell = [PTPerFunCell cellWithTableView:tableView];
            cell.delegate = self;
            cell.countDict = _CountDict;
        return cell;
        }
    }else
    {
        PTSettingCell *cell = [PTSettingCell cellWithTableView:tableView];
        
        PTSettingGroup *group = self.data[indexPath.section];
        
        cell.item = group.items[indexPath.row];
        
        
        return cell;
    }
  
    return nil;
    
}


- (NSMutableDictionary *)CountDict
{
    if (_CountDict == nil) {
        _CountDict = [NSMutableDictionary dictionary];
    }
    return _CountDict;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setDataCount];
}
- (void)setDataCount
{

    [self.CountDict removeAllObjects];
    AVRelation *myGoodsRelation = [[AVUser currentUser]relationforKey:@"myGoods"];
    AVRelation *favoriteRelation = [[AVUser currentUser] relationforKey:@"likeGoods"];
    AVQuery *myQuery = [myGoodsRelation query];
    AVQuery *favoriteQuery = [favoriteRelation query];
    [myQuery countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
    [_CountDict setValue:@(number) forKey:@"myGoodsCount"];
        [favoriteQuery countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error){
            [_CountDict setValue:@(number) forKey:@"favoriteCount"];
            [self.tableView reloadData];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PTSettingGroup *group = self.data[indexPath.section];
    PTCellItem *item = group.items[indexPath.row];
    PTHeadCellItem *arrowItem = (PTHeadCellItem *)item;
    
    if (arrowItem.destVcClass == nil) return;
    
    if (indexPath.section==0 && indexPath.row == 1) {
        return;
    }
    if (indexPath.section==0 && indexPath.row == 0) {
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        vc.title = arrowItem.title;
        if ([AVUser currentUser]) {
            
            [self performSegueWithIdentifier:@"home2persetting" sender:nil];
        }else
        {
            [self performSegueWithIdentifier:@"home2login" sender:nil];
        }
        return;
    }
    if ([item isKindOfClass:[PTSettingArrowItem class]]) {
        PTSettingArrowItem *arrowItem = (PTSettingArrowItem *)item;
        
        if (arrowItem.destVcClass == nil) return;
        
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        vc.title = arrowItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)homeSkip2myGoodsOrFavorite:(int)index
{
    if (index == 1) {
        [self performSegueWithIdentifier:@"home2mygoods" sender:nil];
    }else
    {
        [self performSegueWithIdentifier:@"home2favorite" sender:nil];
    }
}

- (void)loginViewControllerReload
{
    [self setGroup0];
    [self setGroup1];
    [self setGroup3];
    [self.tableView reloadData];
}
- (void)perSettingViewControllerReload
{
    [self setGroup0];
    [self setGroup1];
    [self setGroup3];

    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    id nvc =segue.destinationViewController;
    if ([nvc isKindOfClass:[PTNavigationController class]]) {
        PTNavigationController *addVc = nvc;
        PTLoginViewController *vc = addVc.viewControllers[0];
        vc.delegate = self;
    }else  if([nvc isKindOfClass:[PTPerSettingViewController class]]) {
        PTPerSettingViewController *perVc = nvc;
        perVc.delegate = self;
    }
    
}
@end
