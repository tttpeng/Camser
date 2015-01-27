//
//  PTImageScrollView.m
//  Camser
//
//  Created by iPeta on 15/1/27.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTImageScrollView.h"
#import "PTImageView.h"

@implementation PTImageScrollView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
        self.backgroundColor = [UIColor whiteColor];
            [self addGestureRecognizer:tap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoom2Rect:)];
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];
            [tap requireGestureRecognizerToFail:doubleTap];
        self.scrollsToTop = NO;
        self.maximumZoomScale = 2;
        self.minimumZoomScale =1;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.autoresizesSubviews = NO;
//        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

+ (PTImageScrollView *)imageScrollViewWith:(UIImage *)image andFrame:(CGRect)frame
{
    PTImageScrollView *imageScrollView = [[PTImageScrollView alloc]initWithFrame:frame];
    PTImageView *imageView = [[PTImageView alloc]initWithImage:image];
    [imageScrollView addSubview:imageView];
    return imageScrollView;
}

- (void)zoom2Rect:(UITapGestureRecognizer *)gesture
{
    NSLog(@"====%@",gesture);
    UIScrollView *scrollView = (UIScrollView *)gesture.view;
    CGPoint location = [gesture locationInView:gesture.view];
    if (scrollView.zoomScale == 1) {

    [scrollView zoomToRect:CGRectMake(location.x, location.y, 100, 100) animated:YES];
    }else if(scrollView.zoomScale == 2){
        [scrollView setZoomScale:scrollView.minimumZoomScale animated:YES];
    }
}

-(void)hide:(UITapGestureRecognizer *)gesture
{
    [self.delegate backToDetailViewController];
}

@end
