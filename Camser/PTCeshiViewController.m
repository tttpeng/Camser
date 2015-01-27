//
//  PTCeshiViewController.m
//  Camser
//
//  Created by iPeta on 15/1/26.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCeshiViewController.h"

@interface PTCeshiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PTCeshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 600)];
    view.backgroundColor = [UIColor redColor];

    
    self.tableView.tableHeaderView = view;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"abc"];
        cell.backgroundColor = [UIColor greenColor];
        
        return cell;

}


@end
