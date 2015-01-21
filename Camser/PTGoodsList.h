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

@property (nonatomic,copy) NSDate *created_at;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,strong)NSArray *pictures;

+ (instancetype)listWithName:(NSString *)name iconData:(NSData *)iconData created_at:(NSDate *)created_at text:(NSString *)text price:(NSString *)price pictures:(NSArray *)pictures;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
