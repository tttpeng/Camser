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

@interface PTDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PTDetailInfoViewDelegate,UIGestureRecognizerDelegate>
- (IBAction)sendMessage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *postCommentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
- (IBAction)postCommentBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) PTDetailInfoView *headerView;
@property (strong, nonatomic) NSArray *comments;
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

//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (NSArray *)comments
{
    if (_comments == nil) {
        
        PTGoodsList *goods = self.headerView.goods;
        AVQuery *query = [AVQuery queryWithClassName:@"GoodsList"];
        AVObject *goodsObj = [query getObjectWithId:goods.objectId];
        AVRelation *relation =[goodsObj relationforKey:@"comment"];
        [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"%@",objects);
        }];
        
        
    }
    return  _comments;
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@">>>%@",touch.view);
    if (touch.view == self.headerView.imageScroll) {
        return  NO;
    }
    return YES;
}


/**
 *  监听通知
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame =  [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat transfromY = keyboardFrame.origin.y - self.view.frame.size.height;
    NSLog(@"----%f",keyboardFrame.origin.y);
    NSLog(@">>>>>>%f",self.postCommentView.frame.origin.y);
    NSLog(@"======%f",self.view.frame.size.height);
    [UIView animateWithDuration:duration  animations:^{
        self.postCommentView.transform = CGAffineTransformMakeTranslation(0, transfromY);
    }];
}


- (void)skip2bigViewController:(UIViewController *)viewController
{
//    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:viewController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.comments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
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
//    AVQuery *query = [AVQuery queryWithClassName:@"comment"];
    AVObject *comment = [AVObject objectWithClassName:@"comment"];
    [comment setObject:commentText forKey:@"commentText"];
    [comment setObject:current forKey:@"author"];
    [comment save];
    AVRelation *relation = [goodsobj relationforKey:@"comment"];
    [relation addObject:comment];
    [goodsobj save];
    [MBProgressHUD hideHUD];

    
    
}
@end



