//
//  PTGoodsList.h
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTGoodsList : NSObject

@property (nonatomic,copy) NSString *username;

@property (nonatomic,strong) NSData *iconData;

@property (nonatomic,copy) NSString *created_at;
@property (nonatomic, copy, readonly) NSString *createdTime;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,strong)NSArray *pictures;

@property (nonatomic,copy)NSString *locationString;

@property (nonatomic,strong)NSNumber *goodsType;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
