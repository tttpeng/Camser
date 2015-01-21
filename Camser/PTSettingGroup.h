//
//  PTSettingGroup.h
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTSettingGroup : NSObject

@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,strong) NSArray *items;

@end
