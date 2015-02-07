//
//  PTMyGoodsViewController.m
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTMyGoodsViewController.h"
#import "PTMyGoodsCell.h"
#import "PTGoodsList.h"
#import "PTDetailViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PTMyGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,PTMyGoodsCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *goodses;
@end

@implementation PTMyGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)goodses
{
    if (_goodses == nil) {
        _goodses = [NSMutableArray array];
        [self loadData];
    }
    return _goodses;
}

- (void)loadData
{
    AVUser *curent= [AVUser currentUser];
    AVRelation *relation = [curent relationforKey:@"myGoods"];
    AVQuery *query = [relation query];
    [query includeKey:@"imageArray"];
    [query includeKey:@"author"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (AVObject *goodAv in objects) {
            NSDictionary *dict = [goodAv dictionaryForObject];
            PTGoodsList *goods = [PTGoodsList goodsWithDict:dict];
            [_goodses addObject:goods];
        }
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTMyGoodsCell *cell = [PTMyGoodsCell cellWithTableView:tableView];
    cell.goods = self.goodses[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"mygoods2detail" sender:self.goodses[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PTDetailViewController *vc = segue.destinationViewController;
    vc.goods = sender;
}


-(void)deletaAndReloadTableView
{
    [_goodses removeAllObjects];
    [self loadData];
    [self.tableView reloadData];
}

@end
