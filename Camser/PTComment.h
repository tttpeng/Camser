//
//  PTComment.h
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVUser;
@class PTGoodsList;
@interface PTComment : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,strong)AVUser *user;
@property (nonatomic,copy)NSDate *createdAt;
+ (instancetype)commentWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
