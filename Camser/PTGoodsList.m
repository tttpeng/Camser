//
//  PTGoodsList.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsList.h"
#import "NSDate+PT.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation PTGoodsList


- (instancetype)initWithDict:(NSDictionary *)dict User:(AVUser *)user
{
    if (self = [super init]) {
        self.objectId = dict[@"objectId"];
        self.createdAt  = dict[@"createdAt"];
        self.updatedAt = dict[@"updatedAt"];
        self.text = dict[@"goodsText"];
        self.price = dict[@"price"];
        self.goodsType = dict[@"goodsType"];
        self.locationString = dict[@"locationString"];
        self.pictures = dict[@"imageArray"];
        AVFile *applicantResume = [user objectForKey:@"imageFile"];
        self.iconData = [applicantResume getData];
        self.username = [user objectForKey:@"nickName"];
        self.title = dict[@"title"];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict User:(AVUser *)user
{

    return [[self alloc] initWithDict:dict User:user];

}



- (NSString *)createdTime
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
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
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *sterr = [fmt stringFromDate:createdDate];
        return [fmt stringFromDate:createdDate];
    }
}

@end
