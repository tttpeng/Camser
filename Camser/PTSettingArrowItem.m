//
//  PTSettingArrowItem.m
//  Camser
//
//  Created by iPeta on 15/2/6.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTSettingArrowItem.h"

@implementation PTSettingArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(__unsafe_unretained Class)destVcClass{
    PTSettingArrowItem *item = [[self alloc]init];
    item.image = icon;
    item.title = title;
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
@end
