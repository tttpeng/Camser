//
//  PTDetailInfoView.m
//  Camser
//
//  Created by iPeta on 15/1/26.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTDetailInfoView.h"
#import "PTGoodsList.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PTImageScrollView.h"
#import "UIImage+MJ.h"
#import "PTUser.h"
#import "PTBigViewController.h"


@interface PTDetailInfoView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *DetailDescView;
@property (weak, nonatomic) IBOutlet UIView *DetailDescVIew2;

@end

@implementation PTDetailInfoView


- (void)setGoods:(PTGoodsList *)goods
{
    _goods = goods;
    AVFile *file = [AVFile fileWithURL:goods.user.pic_url];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *icon = [UIImage imageWithData:data];
        self.iconVIew.image = icon;
    }];
   
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",goods.price];
    
    self.username.text = goods.user.nickName;
 
    self.locationLabel.text = goods.locationString;
    
    self.descLabel.text = goods.text;
    
    self.createdTime.text = goods.createdTime;
    
    self.titleLabel.text = goods.title;
    
    self.imageScroll.delegate = self;
    [self setImageList];
    
    
//    [self setImageBackground];

}


- (void)setImageList
{

    int count = (int)self.goods.pic_urls.count;
    CGFloat imageViewW = self.frame.size.width;
    self.pageControl.numberOfPages = count;
    self.imageScroll.contentSize = CGSizeMake( count * imageViewW , imageViewW);
    for (int i = 0; i < count; i ++) {
        AVFile *imageFile = [AVFile fileWithURL:self.goods.pic_urls[i]];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *image = [UIImage imageWithData:data];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(imageViewW * i, 0, imageViewW, imageViewW);
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skip2big:)];
            [imageView addGestureRecognizer:tap];
            [self.imageScroll addSubview:imageView];
        }];
        
        
        
    }
}

- (void)skip2big:(UIGestureRecognizer *)gesture
{
    PTBigViewController *vc = [[PTBigViewController alloc]init];
    vc.currentPage = (int)gesture.view.tag;
    vc.pictures = self.goods.pic_urls;
    [self.delegate skip2bigViewController:vc];
}

+ (instancetype)detailInfoViewWithGoods:(PTGoodsList *)goods
{
    
    PTDetailInfoView *view = [self detailInfoView];
    view.goods = goods;
    return view;
}


+ (instancetype)detailInfoView
{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *objs = [bundle loadNibNamed:@"PTDetailInfoView" owner:nil options:nil];
    return  [objs lastObject];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width;
}
@end
