//
//  PTGoodsList.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsList.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation PTGoodsList

+ (instancetype)listWithName:(NSString *)name iconData:(NSData *)iconData created_at:(NSDate *)created_at text:(NSString *)text price:(NSString *)price pictures:(NSArray *)pictures
{
    PTGoodsList *goodlist = [[PTGoodsList alloc] init];
    goodlist.username = name;
    goodlist.iconData = iconData;
    goodlist.created_at = created_at;
    goodlist.text = text;
    goodlist.price = price;
    goodlist.pictures = pictures;
    return goodlist;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.username = dict[@"author"];
        NSData *imageData = [self comeIcon:_username];
        self.iconData = imageData;
        self.created_at = dict[@"createdAt"];
        self.text = dict[@"goodsText"];
        self.price = dict[@"price"];
//        self.pictures = dict[@"username"];
    }
    return self;
}

- (NSData *)comeIcon:(NSString *)username
{
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"nickName" equalTo:username];
    AVObject *user = [query getFirstObject];
    AVFile *applicantResume = [user objectForKey:@"imageFile"];
    NSData *resumeData = [applicantResume getData];
    UIImage *image = [UIImage imageWithData:resumeData];
    return resumeData;
    
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
