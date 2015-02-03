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
#import "PTComment.h"
#import "PTDetailViewController.h"

@interface PTGoodsListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) AVQuery *query;
@end

@implementation PTGoodsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.970 alpha:1.000];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.970 alpha:1.000];
    [self setupRefresh];
   
}

- (NSMutableArray *)goods
{
    if (_goods == nil) {
        _goods = [NSMutableArray arrayWithArray:[self loadCache:NO]];
    }
    
    return _goods;
}



- (NSArray *)goodsArrayWithAVObjects:(NSArray *)AVArray
{
    NSMutableArray *allGood = [NSMutableArray array];
    for (AVObject *avobj in AVArray) {
        AVUser *goodUser = [avobj objectForKey:@"author"];
        PTGoodsList *goodList = [PTGoodsList goodsWithDict:(NSDictionary *)avobj User:goodUser];
        [allGood addObject:goodList];
    }
    return allGood;
}




/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    //    [self.tableView headerBeginRefreshing];
    
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
    AVQuery* query = [AVQuery queryWithClassName:@"GoodsList"];
    [query includeKey:@"imageArray"];
    [query includeKey:@"author"];
    query.cachePolicy = kPFCachePolicyIgnoreCache;
    
    if (self.goods.count) {
        PTGoodsList *lastGoods = self.goods[0];
        NSDate *lastDate = lastGoods.createdAt;
        [query whereKey:@"createdAt" greaterThan:lastDate];
    }
    
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            NSArray *allGood  = [self goodsArrayWithAVObjects:objects];
            NSRange range=NSMakeRange(0, allGood.count);
            NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
            [self.goods insertObjects:allGood atIndexes:indexSet];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self showNewStatusCount:(int)allGood.count];
            [self loadCache:YES];
        }else
        {
            [self.tableView headerEndRefreshing];
        }
    }];
    
}



- (void)footerRereshing
{
    PTGoodsList *lastGoods = [self.goods lastObject];
    NSDate *lastdate = lastGoods.createdAt;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 5;
    [query whereKey:@"createdAt" lessThan:lastdate];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"imageArray"];
    [query includeKey:@"author"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray *allGood = [self goodsArrayWithAVObjects:objects];
        [self.goods addObjectsFromArray:allGood];
        [self.tableView reloadData];
    }];
    [self.tableView footerEndRefreshing];
}

- (NSArray *)loadCache:(BOOL)isOne
{
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    [query includeKey:@"imageArray"];
    query.limit = 5;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    __block NSMutableArray *array = [NSMutableArray array];
    if(isOne)
    {
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            array = [NSMutableArray arrayWithArray:[self goodsArrayWithAVObjects:objects]];
        }];
    }else{
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            array =  [NSMutableArray arrayWithArray:[self goodsArrayWithAVObjects:objects]];
            self.goods = array;
            [self.tableView reloadData];
        }];
        
    }
    return array;
}

/**
 *  显示最新更新的数量
 *
 *  @param count 最新更新的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    //    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的数据哟~", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新の数据~" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.5 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTGoodsList *goods = self.goods[indexPath.section];
  
    [self performSegueWithIdentifier:@"list2detail" sender:goods];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    PTDetailViewController *detailVc = segue.destinationViewController;
    detailVc.goods = sender;
}
@end
