//
//  PTComment.m
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTComment.h"
#import "PTUser.h"
#import "NSDate+PT.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation PTComment

+ (instancetype)commentWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        self.text = dict[@"commentText"];

        self.user = [PTUser userWithDict:dict[@"author"]];
        NSDictionary *dateDcit = dict[@"createdAt"];
        self.createdAt = dateDcit[@"iso"];
        
        NSLog(@"%@",self.createdAt);
    }
    return self;
}

- (NSString *)createdTime
{
    // _created_at == 2015-01-30T03:13:05.367Z
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'";
#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    NSDate *createdDate = [fmt dateFromString:_createdAt];

    
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
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *sterr = [fmt stringFromDate:createdDate];
        return [fmt stringFromDate:createdDate];
    }
}


@end
