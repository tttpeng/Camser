//
//  PTUser.m
//  Camser
//
//  Created by iPeta on 15/1/30.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTUser.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation PTUser

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.objectId = dict[@"objectId"];
        self.pic_url = dict[@"imageFile"][@"url"];;
        self.nickName = dict[@"nickName"];
        self.userId = dict[@"username"];
    }
    return self;
}


+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
