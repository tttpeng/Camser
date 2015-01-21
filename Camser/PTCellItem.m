//
//  PTCellItem.m
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCellItem.h"

@implementation PTCellItem

+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title
{
    PTCellItem *item = [[PTCellItem alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}
+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title backImage:(NSString *)backIamge
{
    
    PTCellItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.backImage = backIamge;
    return item;
}

@end
