//
//  PTSettingCell.m
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTSettingCell.h"
#import "PTCellItem.h"
#import "PTSettingArrowItem.h"

@interface PTSettingCell()

@property (nonatomic,strong) UIImageView *arrowView;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) UILabel  *labelView;

@end

@implementation PTSettingCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_rightArrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.backgroundColor = [UIColor redColor];
    }
    return _labelView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    PTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PTSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(PTCellItem *)item
{
    _item = item;
    [self setupData];
    [self setupRightContent];
    
}

- (void)setupData
{
    if (self.item.image) {
        self.imageView.image = [UIImage imageNamed:self.item.image];
    }
    
    self.textLabel.text = self.item.title;
    
}

- (void)setupRightContent
{
    if ([self.item isKindOfClass:[PTSettingArrowItem class]]) {
        
        self.accessoryView = self.arrowView;
        
        
    }else if([self.item isKindOfClass:[PTCellItem class]])
    {
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置开关状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
    }
    else if([self.item isKindOfClass:[PTCellItem class]])
    {
        self.accessoryView = self.labelView;
    }else
    {
        self.accessoryView = nil;
    }
}
@end
