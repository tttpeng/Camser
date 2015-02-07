//
//  PTMyGoodsCell.m
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTMyGoodsCell.h"
#import "PTGoodsList.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PTMyGoodsCell()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation PTMyGoodsCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)deletaButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除" message:@"确定删除该条商品吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PTMyGoodsCell";
    PTMyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PTMyGoodsCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setGoods:(PTGoodsList *)goods
{
    _goods = goods;
    AVFile *file = [AVFile fileWithURL:goods.pic_urls[0]];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.iconView.image = [UIImage imageWithData:data];
    }];
    self.title.text = goods.title;
    self.price.text = goods.price;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AVObject *goods = [AVQuery getObjectOfClass:@"GoodsList" objectId:self.goods.objectId];
        [goods deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.delegate deletaAndReloadTableView];
            }
        }];
    }
}
@end
