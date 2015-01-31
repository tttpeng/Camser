//
//  PTTabBarButton.m
//  zzti-second
//
//  Created by iPeta on 14/12/31.
//  Copyright (c) 2014年 河南青云. All rights reserved.
//

#import "PTTabBarButton.h"

@implementation PTTabBarButton

/**
 *  自定义按钮
 */
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat labelX = 0;
    CGFloat labelH = 10;
    CGFloat labelY = self.frame.size.height - labelH - 4;
    CGFloat labelW = self.frame.size.width;
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat imageX = 0;
    CGFloat imageH = 26;
    CGFloat imageY = 7;
    CGFloat imageW = self.frame.size.width;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.titleLabel.font = [UIFont systemFontOfSize:10];//title字体大小
    self.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    
    [self setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0.792 green:0.145 blue:0.133 alpha:1.000] forState:UIControlStateSelected];

     self.imageView.contentMode =UIViewContentModeScaleAspectFit;
}
/**
 *  取消按钮高亮点击状态
 */
-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
