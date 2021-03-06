//
//  PTGoodsList.h
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTUser;
@interface PTGoodsList : NSObject
@property (nonatomic,copy)NSString *objectId;

@property (nonatomic,strong)PTUser *user;

@property (nonatomic,copy)NSString *title;

@property (nonatomic,copy) NSDate *createdAt;

@property (nonatomic, copy, readonly) NSString *createdTime;

@property (nonatomic,strong)NSArray *pic_urls;

@property (nonatomic,copy) NSDate *updatedAt;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,copy)NSString *locationString;

@property (nonatomic,strong)NSNumber *goodsType;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
