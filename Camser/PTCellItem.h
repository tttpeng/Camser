//
//  PTCellItem.h
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PTCellItem : NSObject

@property (nonatomic,weak) NSData *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *backImage;

+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title;
+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title backImage:(NSString *)backIamge;
@end
