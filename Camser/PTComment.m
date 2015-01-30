//
//  PTComment.m
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTComment.h"

@implementation PTComment

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        self.text = dict[@"text"];
        self.user = dict[@"author"];
    }
    
    return self;
}

@end
