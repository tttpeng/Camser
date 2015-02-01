//
//  PTUser.h
//  Camser
//
//  Created by iPeta on 15/1/30.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PTUser : NSObject

@property (nonatomic,copy)NSString *objectId;

@property (nonatomic,strong)UIImage *imageFile;

@property (nonatomic,copy)NSString *nickName;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
