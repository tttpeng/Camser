//
//  PTHeadCellItem.m
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTHeadCellItem.h"

@implementation PTHeadCellItem


+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title backIamge:(NSString *)backImage destVcClass:(__unsafe_unretained Class)destVcClass
{
    
    PTHeadCellItem *item = [self itemWithIcon:icon title:title backImage:backImage];
    item.destVcClass = destVcClass;
    return item;
}
@end
