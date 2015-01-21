//
//  PTHomeCell.m
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTHomeCell.h"
#import "PTCellItem.h"
#import "PTHeadCellItem.h"

@implementation PTHomeCell







- (void)setHeadView
{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.item.backImage]];
    backImageView.frame = CGRectMake(0, 0, 375, 150);
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:self.item.icon]];
    iconView.frame = CGRectMake(40, 60, 60, 60);
    iconView.layer.cornerRadius = iconView.frame.size.width / 2;
    iconView.layer.masksToBounds = YES;
    iconView.layer.borderWidth = 3.0f;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 80, 235, 20)];
    nameLabel.text = self.item.title;
    [self addSubview:backImageView];
    [self addSubview:iconView];
    [self addSubview:nameLabel];
    
}
- (void)setItem:(PTCellItem *)item
{
    _item = item;
    if ([self.item isKindOfClass:[PTCellItem class]]) {
        [self setHeadView];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"head";
    PTHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PTHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
