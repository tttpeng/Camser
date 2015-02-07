//
//  PTPerFunCell.m
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTPerFunCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PTPerFunCell()

@property (weak, nonatomic) IBOutlet UILabel *myGoodsCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;

@end

@implementation PTPerFunCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)myGoodsClick:(UIButton *)sender {

    [self.delegate homeSkip2myGoodsOrFavorite:1];
}

- (IBAction)favoriteBtnClick:(UIButton *)sender {
    [self.delegate homeSkip2myGoodsOrFavorite:2];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"perFunCell";
    PTPerFunCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PTPerFunCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myGoodsCount.text = cell.countDict[@"myGoodsCount"];
        cell.favoriteCount.text = cell.countDict[@"favoriteCount"];
    }
    return cell;
}

-(void)setCountDict:(NSDictionary *)countDict
{
    _countDict = countDict;
    NSString *ste =  [NSString stringWithFormat:@"%d",[countDict[@"myGoodsCount"] intValue]];
    self.myGoodsCount.text = ste;
    self.favoriteCount.text = [NSString stringWithFormat:@"%d",[countDict[@"favoriteCount"] intValue]];
}


@end
