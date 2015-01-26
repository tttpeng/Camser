//
//  NSDate+PT.h
//  Camser
//
//  Created by iPeta on 15/1/19.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (PT)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
