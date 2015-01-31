//
//  PTBorderView.m
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTBorderView.h"

@implementation PTBorderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [UIColor colorWithWhite:0.750 alpha:1.000].CGColor;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0,-3);
//        self.layer.cornerRadius = 10;
//        self.layer.masksToBounds = YES;
//        self.layer.shadowOpacity = 1;

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.layer.cornerRadius = 8;
//        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithWhite:0.752 alpha:1.000].CGColor;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,-3);
        //        self.layer.shadowOpacity = 1;
        
    }
    return self;
}


@end
