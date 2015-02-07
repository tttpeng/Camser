//
//  PTDetailViewController.m
//  Camser
//
//  Created by iPeta on 15/1/26.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTDetailViewController.h"
#import "PTDetailInfoView.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PTLoginViewController.h"
#import "PTGoodsList.h"
#import "MBProgressHUD+PT.h"
#import "PTCommentFrame.h"
#import "PTCommentCell.h"
#import "PTComment.h"
#import "PTUser.h"
#import "MJRefresh.h"


@interface PTDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PTDetailInfoViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *messageImage;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@property (weak, nonatomic) IBOutlet UIView *postCommentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *CommentPostBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) PTDetailInfoView *headerView;
@property (strong,nonatomic) AVUser *replyUser;
- (IBAction)hideKeyboard;

@property (strong,nonatomic) NSMutableArray *commentFrameArray;
- (IBAction)favoriteButton:(id)sender;
- (IBAction)sendMessage:(UIButton *)sender;
- (IBAction)postCommentBtn:(UIButton *)sender;

@end

@implementation PTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PTDetailInfoView *view = [PTDetailInfoView detailInfoViewWithGoods:self.goods];
    view.delegate = self;
    self.tableView.tableHeaderView = view;
    self.headerView = view;
    [self checkFavorite];
//    [self checkFavoriteCount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.970 alpha:1.000];
    
    _commentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self setupRefresh];
    
//    self.loadingView.hidden = YES;
}


- (void)viewDidAppear:(BOOL)animated
{
//    [self loadComments];
    [self checkCommentCount];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(loadComments)];
    [self.tableView footerBeginRefreshing];

    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"哥我正在帮你加载中";
}

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (void)commentFooterRereshing
{
    [self loadComments];
    [self.tableView footerEndRefreshing];
}

- (void)checkCommentCount
{
    PTGoodsList *goods = self.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query getObjectInBackgroundWithId:goods.objectId block:^(AVObject *object, NSError *error) {
        AVObject *goodsObj = object;
        AVRelation *relation =[goodsObj relationforKey:@"comment"];
        AVRelation *attendRelation = [goodsObj relationforKey:@"likedUser"];
        AVQuery *queryAttend = [attendRelation query];
        AVQuery *queryC = [relation query];
        [queryC countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
                 [self.CommentPostBtn setTitle:[NSString stringWithFormat:@"%ld",(long)number] forState:UIControlStateNormal];
        }];
        [queryAttend countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {

             [self.favoriteButton setTitle:[NSString stringWithFormat:@"%ld",(long)number] forState:UIControlStateNormal];
        }];
   
       
        
        
    }];
}


- (void)loadComments
{
    PTGoodsList *goods = self.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query getObjectInBackgroundWithId:goods.objectId block:^(AVObject *object, NSError *error) {
        PTComment *lastComment = [self.comments lastObject];
        NSDate *lastdate;
        if (lastComment) {
            lastdate = lastComment.createdAt;
        }else
        {
            lastdate = [NSDate date];
        }
                AVObject *goodsObj = object;
        AVRelation *relation =[goodsObj relationforKey:@"comment"];
        
        AVQuery *queryC = [relation query];
        NSLog(@"lastdate:------%@",lastdate);
        [queryC whereKey:@"createdAt" lessThan:lastdate];
        [queryC orderByDescending:@"createdAt"];
        [queryC includeKey:@"author"];
        [queryC includeKey:@"replyTo"];
        queryC.limit = 5;
        queryC.cachePolicy = kPFCachePolicyNetworkElseCache;
        [queryC findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [self.comments addObjectsFromArray:[self commentsFrameArrayWidthAvojArray:objects]];
            [self setCommentFrame];
            [self.tableView reloadData];
            self.loadingView.hidden = YES;
            [self.tableView footerEndRefreshing];
        }];
    }];
}

- (void)loadingMore
{
    PTGoodsList *goods = self.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query getObjectInBackgroundWithId:goods.objectId block:^(AVObject *object, NSError *error) {
        PTComment *firstComment = [self.comments firstObject];
        NSDate *firstDate;
        if (firstComment) {
            firstDate = firstComment.createdAt;
        }else
        {
            firstDate = [NSDate date];
        }
        
        AVObject *goodsObj = object;
        AVRelation *relation =[goodsObj relationforKey:@"comment"];
        
        AVQuery *queryC = [relation query];
        NSLog(@"lastdate:------%@",firstDate);
        [queryC whereKey:@"createdAt" greaterThan:firstDate];
        [queryC orderByDescending:@"createdAt"];
        [queryC includeKey:@"author"];
        [queryC includeKey:@"replyTo"];
        queryC.cachePolicy = kPFCachePolicyNetworkElseCache;
        [queryC findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray *comments = [self commentsFrameArrayWidthAvojArray:objects];
            NSRange range=NSMakeRange(0, comments.count);
            NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
            [self.comments insertObjects:comments atIndexes:indexSet];
            [self setCommentFrame];
            [self.tableView reloadData];
        }];
    }];
    
}

- (void)setCommentFrame
{
    _commentFrameArray = nil;
    for (PTComment *comment in _comments) {
        PTCommentFrame *cf = [[PTCommentFrame alloc]init];
        cf.goodsComment = comment;
        [self.commentFrameArray addObject:cf];
    }
}


- (NSArray *)commentsFrameArrayWidthAvojArray:(NSArray *)array
{   NSMutableArray *commentArray = [NSMutableArray array];
    for (AVObject *oneComment in array) {
        NSDictionary *dict = [oneComment dictionaryForObject];
        PTComment *comment = [PTComment commentWithDict:dict];
        [commentArray addObject:comment];
    }
    return commentArray;
}

- (IBAction)hideKeyboard {
    CGRect tempRect = _messageView.frame;
    tempRect.origin.y  =  tempRect.origin.y + tempRect.size.height - 47;
    tempRect.size.height = 47;
    _messageView.frame = tempRect;
    _messageView.transform = CGAffineTransformIdentity;
    [self.commentTextView resignFirstResponder];
}

- (NSMutableArray *)commentFrameArray
{
    if (_commentFrameArray == nil) {
        _commentFrameArray = [NSMutableArray array];
    }
    return _commentFrameArray;
}



- (void)checkFavoriteCount
{

    NSError *error;
    AVObject *goodsCon = [AVQuery getObjectOfClass:@"GoodsList" objectId:self.goods.objectId error:&error];


    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"likeGoods" equalTo:goodsCon];
    [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        NSLog(@"-------<>%ld",(long)number);
        [self.favoriteButton setTitle:[NSString stringWithFormat:@"%ld",(long)number] forState:UIControlStateNormal];
    }];
   
    
}


-(void)checkFavorite
{
    AVUser *current = [AVUser currentUser];
    AVRelation *relation = [current relationforKey:@"likeGoods"];
    AVQuery *query = [relation query];
    [query whereKey:@"objectId" equalTo:_goods.objectId];
        [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number) {
            self.favoriteButton.selected = YES;
        }else
        {
            self.favoriteButton.selected = NO;
        }
        NSLog(@"-------->%ld",(long)number);
    }];

}

- (IBAction)favoriteButton:(id)sender {
    if ([self whetherLogin]) {
        AVUser *current = [AVUser currentUser];
        PTGoodsList *goods = self.goods;
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        NSError *error;
        AVObject *goodsobj = [query getObjectWithId:goods.objectId error:&error];
        NSLog(@"%@",error);
        AVRelation *relation = [current relationforKey:@"likeGoods"];
        AVRelation *goodsRelation = [goodsobj relationforKey:@"likedUser"];
        if (current) {
            if (self.favoriteButton.selected == YES) {
                self.favoriteButton.selected = NO;
                [relation removeObject:goodsobj];
                [goodsRelation removeObject:current];
                [goodsobj saveInBackground];
                [current saveInBackground];
                [self checkFavoriteCount];
                NSString *count = self.favoriteButton.titleLabel.text;
                NSInteger countValue = [count intValue];
                [self.favoriteButton setTitle:[NSString stringWithFormat:@"%ld",countValue - 1] forState:UIControlStateNormal];
                
            }else{
                self.favoriteButton.selected = YES;
                [relation addObject:goodsobj];
                [goodsRelation addObject:current];
                [goodsobj saveInBackground];
                [current saveInBackground];
                NSString *count = self.favoriteButton.titleLabel.text;
                NSInteger countValue = [count intValue];
                [self.favoriteButton setTitle:[NSString stringWithFormat:@"%ld",countValue + 1] forState:UIControlStateNormal];
            }
            
        }
    }
    
}

/**
 *  监听通知
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat transfromY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration  animations:^{
        self.postCommentView.transform = CGAffineTransformMakeTranslation(0, transfromY);
    }];
}


- (void)skip2bigViewController:(UIViewController *)viewController
{
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:viewController animated:YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTCommentCell *cell = [PTCommentCell cellWithTableView:tableView];
    cell.commentFrame = self.commentFrameArray[indexPath.row];
    return cell;
}


- (BOOL)whetherLogin
{
    if ([AVUser currentUser]) {
        return YES;
    }else
    {
        [self performSegueWithIdentifier:@"detail2login" sender:nil];
        return NO;
    }
}


- (IBAction)postCommentBtn:(UIButton *)sender {
    
    if ([self whetherLogin]) {
        _replyUser = nil;
        [self.commentTextView becomeFirstResponder];
        
    }
}
- (IBAction)sendMessage:(UIButton *)sender {
    
    [self hideKeyboard];
    [MBProgressHUD showMessage:@"正在评论"];
    PTGoodsList *goods = self.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    AVObject *goodsobj = [query getObjectWithId:goods.objectId];
    
    AVUser *current = [AVUser currentUser];
    NSString *commentText = self.commentTextView.text;
    AVObject *comment = [AVObject objectWithClassName:@"comment"];
    [comment setObject:commentText forKey:@"commentText"];
    [comment setObject:current forKey:@"author"];
    [comment setObject:_replyUser forKey:@"replyTo"];
    [comment save];
    
    AVRelation *relation = [goodsobj relationforKey:@"comment"];
    [relation addObject:comment];
    [goodsobj save];
    
    _messageView.transform = CGAffineTransformIdentity;
    [self loadComments];
    _replyUser = nil;
    self.commentTextView.text = nil;
    [self loadingMore];
     [self checkCommentCount];
    [MBProgressHUD hideHUD];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTCommentFrame *cf = self.commentFrameArray[indexPath.row];
    return cf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTComment *comment = self.comments[indexPath.row];
    NSLog(@"%@,%@",[AVUser currentUser].objectId,comment.user.objectId);
    if (![[AVUser currentUser].objectId isEqual:comment.user.objectId]) {
        [self postCommentBtn:nil];
        AVQuery * query =[AVQuery queryWithClassName:@"_User"];
        [query whereKey:@"objectId" equalTo:comment.user.objectId];
        AVObject *user = [query getFirstObject];
        _replyUser = (AVUser *)user;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(260, MAXFLOAT);
    CGSize size = [textView.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    CGRect tmpRect = _messageView.frame;
    CGFloat textH = size.height + 16;
    CGFloat ViewH = textH + 15;
    [UIView animateWithDuration:0.2 animations:^{
        _messageView.frame = CGRectMake(0, tmpRect.origin.y + (tmpRect.size.height - ViewH), 375, ViewH);
        _commentTextView.frame = CGRectMake(48, 7, 270, textH);
    }];
}


@end



