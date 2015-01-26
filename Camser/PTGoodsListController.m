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
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.820 alpha:1.000];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupRefresh];
}

- (NSMutableArray *)goods
{
    if (_goods == nil) {
        AVQuery *query = [self obtainData];
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


- (AVQuery *)obtainData
{
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 5;
    [query includeKey:@"imageArray"];
    [query orderByDescending:@"createdAt"];
    
    return query;
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
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




- (void)headerRereshing
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        [query includeKey:@"imageArray"];
//        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
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
                self.total = count;
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
        NSString *lastString =   lastGoods.created_at;
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
        NSDate *lastdate =[dateFormat dateFromString:lastString];
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        query.limit = 5;
        [query whereKey:@"createdAt" lessThan:lastdate];
        [query orderByDescending:@"createdAt"];
        [query includeKey:@"imageArray"];
        
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
            }
            
        }];
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
