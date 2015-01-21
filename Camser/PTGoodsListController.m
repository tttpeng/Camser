//
//  PTGoodsListController.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsListController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "PTGoodsList.h"
#import "PTGoodsListCell.h"
#import "MJRefresh.h"

@interface PTGoodsListController ()
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, assign) NSInteger total;
@end

@implementation PTGoodsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.680 alpha:1.000];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupRefresh];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)goods
{
    if (_goods == nil) {
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        query.limit = 5;
        [query orderByDescending:@"createdAt"];
        NSInteger count = query.countObjects;
        NSLog(@"一共多少条数据%ld",(long)count);
        self.total = count;
        NSMutableArray *allGood = [NSMutableArray array];
        NSArray *ditArray = [query findObjects];
        for (NSDictionary *dict in ditArray) {
            PTGoodsList *goodList = [PTGoodsList goodsWithDict:dict];
            [allGood addObject:goodList];
        }
        _goods = allGood;
    }
    
    return _goods;
}


- (void)setData
{
    
    
}




/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"哥我正在帮你刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"哥我正在帮你加载中";
}



- (void)setupRefresh1
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    [refreshControl addTarget:self action:(@selector(refreshControlStateChange:)) forControlEvents:UIControlEventValueChanged];
    //    [self loadNewStatus];
}
-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        
        NSInteger count = [query countObjects];
        if (count > self.total) {
            
            NSMutableArray *allGood = [NSMutableArray array];
            query.limit = count - self.total;
            [query orderByDescending:@"createdAt"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                NSArray *ditArray = objects;
                for (NSDictionary *dict in ditArray) {
                    PTGoodsList *goodList = [PTGoodsList goodsWithDict:dict];
                    [allGood addObject:goodList];
                }
                //把新数据添加到旧数据的前面
                NSRange range=NSMakeRange(0, allGood.count);
                NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
                [self.goods insertObjects:allGood atIndexes:indexSet];
                self.total = self.goods.count;
                [self.tableView reloadData];
                
            }];
            
            
        }
        [refreshControl endRefreshing];
        
        
    });
    
    
    
}

- (void)headerRereshing
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        
        NSInteger count = [query countObjects];
        if (count > self.total) {
            
            NSMutableArray *allGood = [NSMutableArray array];
            query.limit = count - self.total;
            [query orderByDescending:@"createdAt"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                NSArray *ditArray = objects;
                for (NSDictionary *dict in ditArray) {
                    PTGoodsList *goodList = [PTGoodsList goodsWithDict:dict];
                    [allGood addObject:goodList];
                }
                //把新数据添加到旧数据的前面
                NSRange range=NSMakeRange(0, allGood.count);
                NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
                [self.goods insertObjects:allGood atIndexes:indexSet];
                self.total = self.goods.count;
                [self.tableView reloadData];
                
                [self.tableView headerEndRefreshing];
                
                
            }];
            
            
        }
        
        // 刷新表格
        //        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
        
    });
    
}

- (void)footerRereshing
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PTGoodsList *lastGoods =     [self.goods lastObject];
        NSDate *lastdate =   lastGoods.created_at;
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        query.limit = 5;
        [query whereKey:@"createdAt" lessThan:lastdate];
        [query orderByDescending:@"createdAt"];
        
        
        
        NSMutableArray *allGood = [NSMutableArray array];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray *ditArray = objects;
            if (ditArray) {
                for (NSDictionary *dict in ditArray) {
                    PTGoodsList *goodList = [PTGoodsList goodsWithDict:dict];
                    [allGood addObject:goodList];
                }
                [self.goods addObjectsFromArray:allGood];
                [self.tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                
                
            }
            
        }];
        
        
        
        
        
        // 刷新表格
        
    });
    [self.tableView footerEndRefreshing];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.goods.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTGoodsListCell *cell = [PTGoodsListCell cellWithTableView:tableView];
    cell.goodsList = self.goods[indexPath.section];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}



@end
