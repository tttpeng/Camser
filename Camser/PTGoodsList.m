//
//  PTGoodsList.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsList.h"
#import "NSDate+PT.h"
#import "PTUser.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation PTGoodsList



- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.objectId = dict[@"objectId"];
        self.user = [PTUser userWithDict:dict[@"author"]];
        self.createdAt  = [self changeDate:dict[@"createdAt"][@"iso"]];
        self.updatedAt = [self changeDate:dict[@"updatedAt"][@"iso"]];
        self.text = dict[@"goodsText"];
        self.price = dict[@"price"];
        NSArray *imageArray = dict[@"imageArray"];
        NSMutableArray *array =[NSMutableArray array];
        for (NSDictionary *dict in imageArray) {
            NSString *url = dict[@"url"];
            [array addObject:url];
        }
        self.pic_urls = array;
        self.goodsType = dict[@"goodsType"];
        self.locationString = dict[@"locationString"];
        self.title = dict[@"title"];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];

}


- (NSDate *)changeDate:(NSString *)dateStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:s.SSSZ";
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [fmt dateFromString:dateStr];
    return date;
    
}


- (NSString *)createdTime
{
    // _created_at == 2015-01-30T03:13:05.367Z
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:s.SSSZ";
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
//    NSDate *createdDate = [fmt dateFromString:_createdAt];
    NSDate *createdDate = _createdAt;
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        //        fmt.dateFormat = @"MM-dd HH:mm";
        return [NSString stringWithFormat:@"%ld天前", (long)createdDate.deltaWithNow.day];
        
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}


@end
