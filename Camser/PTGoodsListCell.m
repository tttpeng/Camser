//
//  PTGoodsListCell.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsListCell.h"
#import "PTGoodsList.h"
#import <AVOSCloud/AVOSCloud.h>


@interface PTGoodsListCell ()

@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UIButton *nameButton;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *descLabel;
@property (nonatomic,weak) UILabel *priceLabel;
@property (nonatomic,weak) UIImageView *goodTypeImage;
@property (nonatomic,weak) UILabel *localLabel;
@property (nonatomic,weak) UIView *divideLine;
@property (nonatomic,weak) UIButton *attentionBtn;
@property (nonatomic,weak) UIButton *reviewBtn;
@property (nonatomic,weak) UIButton *shareBtn;
@property (nonatomic,weak) UIScrollView *imageScrollView;



@end
@implementation PTGoodsListCell




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    PTGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PTGoodsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setContentView];
    }
    return self;

}


- (void)setGoodsList:(PTGoodsList *)goodsList
{
    _goodsList = goodsList;
    [self setData];
}

- (void)setContentView
{
    
    CGFloat iconViewX = 12;
    CGFloat iconViewY = 12;
    CGFloat iconViewH = 40;
    CGFloat iconViewW = 40;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
//    iconView.image = [UIImage imageNamed:@"ceshitouxiang"];
    iconView.layer.cornerRadius = iconView.frame.size.width / 2;
    iconView.layer.masksToBounds = YES;
    iconView.layer.borderWidth = 3.0f;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    
    CGFloat imageScrollX = 12;
    CGFloat imageScrollY = 141;
    CGFloat imageScrollW = 363;
    CGFloat imageScrollH = 105;
    
    UIScrollView *imageScroll = [[UIScrollView alloc]init];
    imageScroll.showsVerticalScrollIndicator = NO;
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.frame = CGRectMake(imageScrollX, imageScrollY, imageScrollW, imageScrollH);
    [self.contentView addSubview:imageScroll];
    self.imageScrollView = imageScroll;
    
    CGFloat nameButtonX = 55;
    CGFloat nameButtonY = 20;
    CGFloat nameButtonW = 200;
    CGFloat nameButtonH = 20;
    UIButton *nameButton = [[UIButton alloc]init];
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    nameButton.titleLabel.textAlignment =  NSTextAlignmentLeft;
    nameButton.frame = CGRectMake(nameButtonX, nameButtonY, nameButtonW, nameButtonH);
    [nameButton setTitleColor:[UIColor colorWithRed:0.060 green:0.057 blue:0.056 alpha:1.000] forState:UIControlStateNormal];
    nameButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.nameButton = nameButton;
    [self.contentView addSubview:nameButton];
    
    CGFloat createTimeX = 290;
    CGFloat createTimeY = 20;
    CGFloat createTimeW = 70;
    CGFloat createTimeH = 15;
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.frame = CGRectMake(createTimeX, createTimeY, createTimeW, createTimeH);
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    CGFloat textX = 12;
    CGFloat textY = 55;
    CGFloat textW = 350;
    CGFloat textH = 50;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    textLabel.frame = CGRectMake(textX, textY, textW, textH);
    textLabel.numberOfLines = 2;
    self.descLabel = textLabel;
    [self.contentView addSubview:textLabel];
    
    
    CGFloat priceLabelX = 50;
    CGFloat priceLabelY = 112;
    CGFloat priceLabelW = 55;
    CGFloat priceLabelH = 16;
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:1];
    priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    self.priceLabel = priceLabel;
    [self.contentView addSubview:priceLabel];
    
    CGFloat tagLabelX =12 ;
    CGFloat tagLabelY =112 ;
    CGFloat tagLabelW =34 ;
    CGFloat tagLabelH =16 ;
    
    UIImageView *goodTypeImage =[[UIImageView alloc] init];
    goodTypeImage.frame = CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH);
    goodTypeImage.image = [UIImage imageNamed:@"home_sale"];
    self.goodTypeImage = goodTypeImage;
    [self.contentView addSubview:goodTypeImage];
    
    UILabel *localLabel = [[UILabel alloc] init];
    localLabel.frame = CGRectMake(12, 253, 61, 30);
    localLabel.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
    localLabel.layer.cornerRadius = 10;
    localLabel.layer.masksToBounds = YES;
    localLabel.textAlignment = NSTextAlignmentCenter;
    self.localLabel = localLabel;
    [self.contentView addSubview:localLabel];
    
    UIView *divideLine = [[UIView alloc] init];
    divideLine.frame = CGRectMake(0, 291, 375, 1);
    divideLine.backgroundColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    divideLine.alpha = 0.3;
    [self.contentView addSubview:divideLine];
    
    CGFloat attentionBtnX = 0;
    CGFloat attentionBtnY = 291;
    CGFloat attentionBtnW = 125;
    CGFloat attentionBtnH = 44;
    
    UIButton *attentionBtn = [[UIButton alloc] init];
    attentionBtn.frame = CGRectMake(attentionBtnX, attentionBtnY, attentionBtnW, attentionBtnH);
    [attentionBtn setImage:[UIImage imageNamed:@"home_collect"] forState:UIControlStateNormal];
    [attentionBtn setTitle:@"4" forState:UIControlStateNormal];
    [attentionBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [self.contentView addSubview:attentionBtn];
    
    UIButton *reviewBtn = [[UIButton alloc] init];
    reviewBtn.frame = CGRectMake(attentionBtnX + 125, attentionBtnY, attentionBtnW, attentionBtnH);
    [reviewBtn setImage:[UIImage imageNamed:@"home_comment"] forState:UIControlStateNormal];
    [reviewBtn setTitle:@"13" forState:UIControlStateNormal];
    reviewBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [reviewBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:reviewBtn];
    
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.frame = CGRectMake(attentionBtnX + 250, attentionBtnY, attentionBtnW, attentionBtnH);
    [shareBtn setImage:[UIImage imageNamed:@"home_share"] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [shareBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:shareBtn];
    
}


- (void)setData
{
    
    [self.nameButton setTitle:self.goodsList.username forState:UIControlStateNormal];
    
    self.localLabel.text = @"金水区";
    self.timeLabel.text = self.goodsList.createdTime;
    self.localLabel.text = self.goodsList.locationString;
    self.descLabel.text = self.goodsList.text;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsList.price];

    self.iconView.image = [UIImage imageWithData:self.goodsList.iconData];
    
    
    CGFloat oneImageY = 0;
    CGFloat oneImageW = 105;
    CGFloat oneImageH = 105;
    [self.imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageScrollView.contentSize = CGSizeMake((oneImageW + 5) * self.goodsList.pictures.count, oneImageH);
    for (int i = 0; i < self.goodsList.pictures.count; i++) {
        UIImageView *oneImage = [[UIImageView alloc] init];
        oneImage.contentMode = UIViewContentModeScaleAspectFill;
        oneImage.clipsToBounds = YES;
        oneImage.frame = CGRectMake((oneImageW + 5) * i, oneImageY, oneImageW, oneImageH);
        [self.imageScrollView addSubview:oneImage];
        AVFile *imagefile = self.goodsList.pictures[i];
        [imagefile getThumbnail:YES width:300 height:300 withBlock:^(UIImage *image, NSError *error) {
            oneImage.image = image;
        }];
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
