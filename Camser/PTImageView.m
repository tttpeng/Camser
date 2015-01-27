//
//  PTImageView.m
//  Camser
//
//  Created by iPeta on 15/1/27.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTImageView.h"

@implementation PTImageView


- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
//        if (image.size.width > image.size.height) {
            CGFloat imageH = image.size.height;
            CGFloat imageW = image.size.width;
            self.frame = CGRectMake(0 , (667 - (375/imageW)* imageH) * 0.5 , 375, (375/imageW)* imageH);
//        self.backgroundColor = [UIColor redColor];
//        }else
//        {
//            self.frame = CGRectMake(0 , 0 , 375, 667);
//            self.contentMode = UIViewContentModeScaleAspectFill;
//        }
        
    }
    return self;
}


@end
