//
//  PTComment.h
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTUser;
@class PTGoodsList;
@interface PTComment : NSObject

@property (nonatomic,copy)NSString *text;

@property (nonatomic,strong)PTUser *user;

@property (nonatomic,strong)PTUser *replyUser;

@property (nonatomic,copy)NSString *createdAt;


@property (nonatomic, copy, readonly) NSString *createdTime;


+ (instancetype)commentWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
