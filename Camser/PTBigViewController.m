//
//  PTBigViewController.m
//  Camser
//
//  Created by iPeta on 15/1/27.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTBigViewController.h"
#import "PTImageScrollView.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PTBigViewController ()<UIScrollViewDelegate,PTImageScrollViewDelegate>

@property (nonatomic,weak)UILabel *numberLabel;
@property (nonatomic,weak)UIScrollView *bigScrollView;

@end

@implementation PTBigViewController


-(void)viewDidLoad
{
    UIScrollView *bigScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    bigScrollView.backgroundColor = [UIColor colorWithRed:0.901 green:1.000 blue:0.942 alpha:1.000];
    [self.view addSubview:bigScrollView];
    bigScrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.pictures.count, self.view.frame.size.height);
    bigScrollView.pagingEnabled = YES;
    bigScrollView.delegate = self;
    bigScrollView.showsHorizontalScrollIndicator = NO;
    bigScrollView.showsVerticalScrollIndicator = NO;
    bigScrollView.alwaysBounceHorizontal = YES;
    self.bigScrollView = bigScrollView;
    bigScrollView.contentOffset = CGPointMake(_currentPage * bigScrollView.frame.size.width, 0);
    for (int i = 0; i < self.pictures.count; i ++) {
        AVFile *imageFile = [AVFile fileWithURL:self.pictures[i]];
        NSData *data = [imageFile getData];
        UIImage * image = [UIImage imageWithData:data];
        PTImageScrollView *imageScrollView = [PTImageScrollView imageScrollViewWith:image andFrame:CGRectMake(i * bigScrollView.frame.size.width, 0, bigScrollView.frame.size.width, bigScrollView.frame.size.height)];
        imageScrollView.delegate = self;
        [bigScrollView addSubview:imageScrollView];
    }
    
    UILabel *numberLable = [[UILabel alloc] init];
    numberLable.frame = CGRectMake(310, 20, 60, 30);
    numberLable.text = [NSString stringWithFormat:@"%d/%d",self.currentPage + 1, (int)self.pictures.count];
    numberLable.font = [UIFont systemFontOfSize:30];
    self.numberLabel = numberLable;
    [self.view addSubview:numberLable];
    

}


- (void)backToDetailViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
    
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    UIImageView *imageView = scrollView.subviews[0];
    if (imageView.image == nil) return;
    CGSize boundsSize = scrollView.bounds.size;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = imageView.frame.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGRect imageFrame = CGRectMake(imageView.frame.origin.x, 0, imageWidth, imageHeight);
    
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
        
    }else{
        imageFrame.origin.y = 0;
    }
    
    imageView.frame = imageFrame;
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.bigScrollView) return;
    NSString *preNum = self.numberLabel.text;

    int number = scrollView.contentOffset.x/self.view.frame.size.width;

    NSString *numberstr = [NSString stringWithFormat:@"%d/%d",number + 1,(int)self.pictures.count];
    
    if (![preNum isEqualToString:numberstr]) {
        for (UIScrollView *view in self.bigScrollView.subviews) {
            view.zoomScale = 1;
        }
    }
    self.numberLabel.text = numberstr;
}

- (void)hide:(UIGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
