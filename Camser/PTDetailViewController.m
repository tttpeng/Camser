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
#import "PTGoodsList.h"
#import "MBProgressHUD+PT.h"
#import "PTCommentFrame.h"
#import "PTCommentCell.h"
#import "PTComment.h"


@interface PTDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PTDetailInfoViewDelegate,UIGestureRecognizerDelegate>
- (IBAction)sendMessage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *postCommentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
- (IBAction)postCommentBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) PTDetailInfoView *headerView;
@property (strong,nonatomic) NSMutableArray *commentFrameArray;
- (IBAction)favoriteButton:(id)sender;

@end

@implementation PTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PTDetailInfoView *view = [PTDetailInfoView detailInfoViewWithGoods:self.goods];
    view.delegate = self;
    self.tableView.tableHeaderView = view;
    self.headerView = view;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
}

- (NSMutableArray *)commentFrameArray
{
    if (_commentFrameArray == nil) {
        _commentFrameArray = [NSMutableArray array];
        [self loadComments];
        for (PTComment *comment in _comments) {
        PTCommentFrame *cFrame = [[PTCommentFrame alloc] init];
            cFrame.goodsComment = comment;
            [_commentFrameArray addObject:cFrame];
        }
        
    }
    return _commentFrameArray;
}


- (void)loadComments
{
    PTGoodsList *goods = self.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    AVObject *goodsObj = [query getObjectWithId:goods.objectId];
    AVRelation *relation =[goodsObj relationforKey:@"comment"];
    
    AVQuery *queryC = [relation query];
    [queryC includeKey:@"author"];
    NSArray *array = [queryC findObjects];
    
    NSMutableArray *commentArray = [NSMutableArray array];
    for (AVObject *oneComment in array) {
        NSDictionary *dict = [oneComment dictionaryForObject];
        PTComment *comment = [PTComment commentWithDict:dict];
        NSLog(@">>>%@",dict);
        [commentArray addObject:comment];
    }
    self.comments = commentArray;
}
-(BOOL)checkFavorite
{
    PTGoodsList *goods = self.headerView.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    AVObject *goodsobj = [query getObjectWithId:goods.objectId];
    AVUser *current = [AVUser currentUser];
    AVRelation *relation = [current relationforKey:@"likeGoods"];
    NSLog(@".>>>%@",goodsobj.objectId);
    NSArray *array = [[relation query] findObjects];
    for (AVObject *see in array) {
        NSLog(@"--------%@",see.objectId);
        if ([see.objectId isEqualToString:goodsobj.objectId])
        {
            self.favoriteButton.selected = YES;
            return YES;
        }
    }
    return self.favoriteButton.selected = NO;
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



- (IBAction)favoriteButton:(id)sender {
    AVUser *current = [AVUser currentUser];
    if (current) {
        if (self.favoriteButton.selected == YES) {
            self.favoriteButton.selected = NO;
        }else
            self.favoriteButton.selected = YES;
    }
}
- (IBAction)postCommentBtn:(UIButton *)sender {
    
    [self.commentTextView becomeFirstResponder];
}
- (IBAction)sendMessage:(UIButton *)sender {

    [self.commentTextView resignFirstResponder];
    [MBProgressHUD showMessage:@"正在评论"];
    PTGoodsList *goods = self.headerView.goods;
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
    AVObject *goodsobj = [query getObjectWithId:goods.objectId];

    AVUser *current = [AVUser currentUser];
    NSString *commentText = self.commentTextView.text;
    AVObject *comment = [AVObject objectWithClassName:@"comment"];
    [comment setObject:commentText forKey:@"commentText"];
    [comment setObject:current forKey:@"author"];
    [comment save];
    
    AVRelation *relation = [goodsobj relationforKey:@"comment"];
    [relation addObject:comment];
    [goodsobj save];
    [_commentFrameArray removeAllObjects];
    _commentFrameArray = nil;
    [self.tableView reloadData];
    [MBProgressHUD hideHUD];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTCommentFrame *cf = self.commentFrameArray[indexPath.row];
    return cf.cellHeight;
}

@end



