//
//  PTGoodsListCell.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsListCell.h"
#import "PTGoodsList.h"
#import "PTBorderView.h"
#import "UIImage+MJ.h"
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
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.970 alpha:1.000];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setbackView];
    }
    return self;
    
}


- (void)setGoodsList:(PTGoodsList *)goodsList
{
    _goodsList = goodsList;
    [self setData];
}

- (void)setbackView
{
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat padding = 10.0f;
    
    UIView *backView = [[PTBorderView alloc] init];
    backView.frame = CGRectMake(padding, 5, kWidth - padding * 2, 275);
    [self.contentView addSubview:backView];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.frame=  backView.bounds;
    UIImage *backImage = [UIImage imageNamed:@"cm2_act_post_bg"];
    backImage = [UIImage resizedImageWithName:@"cm2_act_post_bg"];
    backImageView.image = backImage;
    [backView addSubview:backImageView];
    
    
    
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewH = 35;
    CGFloat iconViewW = 35;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    iconView.layer.cornerRadius = iconView.frame.size.width / 2;
    iconView.layer.masksToBounds = YES;
    self.iconView = iconView;
    [backView addSubview:iconView];
    
    CGFloat nameButtonX = CGRectGetMaxX(self.iconView.frame) + padding;
    CGFloat nameButtonY = padding;
    CGFloat nameButtonW = 200;
    CGFloat nameButtonH = iconViewH;
    UIButton *nameButton = [[UIButton alloc]init];
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    nameButton.titleLabel.textAlignment =  NSTextAlignmentLeft;
    nameButton.frame = CGRectMake(nameButtonX, nameButtonY, nameButtonW, nameButtonH);
    [nameButton setTitleColor:[UIColor colorWithRed:0.060 green:0.057 blue:0.056 alpha:1.000] forState:UIControlStateNormal];
    nameButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.nameButton = nameButton;
    [backView addSubview:nameButton];
    

    CGFloat createTimeY = padding;
    CGFloat createTimeW = 70;
    CGFloat createTimeH = iconViewH;
    CGFloat createTimeX = kWidth - 3 * padding - createTimeW;
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.frame = CGRectMake(createTimeX, createTimeY, createTimeW, createTimeH);
    self.timeLabel = timeLabel;
    [backView addSubview:timeLabel];
    
    CGFloat textX = padding;
    CGFloat textY = CGRectGetMaxY(iconView.frame) + padding * 0.2;
    CGFloat textW = kWidth - 4 * padding;
    CGFloat textH = 50;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    textLabel.frame = CGRectMake(textX, textY, textW, textH);
    textLabel.numberOfLines = 2;
    self.descLabel = textLabel;
    [backView addSubview:textLabel];
    
    
    CGFloat tagLabelX =padding ;
    CGFloat tagLabelY =CGRectGetMaxY(textLabel.frame) + padding * 0.3;
    CGFloat tagLabelW =35;
    CGFloat tagLabelH =16;
    
    UIImageView *goodTypeImage =[[UIImageView alloc] init];
    goodTypeImage.frame = CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH);
    goodTypeImage.image = [UIImage imageNamed:@"home_sale"];
    self.goodTypeImage = goodTypeImage;
    [backView addSubview:goodTypeImage];
    
    CGFloat priceLabelX = CGRectGetMaxX(goodTypeImage.frame) + padding;
    CGFloat priceLabelY = tagLabelY;
    CGFloat priceLabelW = 105;
    CGFloat priceLabelH = tagLabelH;
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:1];
    priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    self.priceLabel = priceLabel;
    [backView addSubview:priceLabel];
    
    CGFloat imageScrollX = padding;
    CGFloat imageScrollY = CGRectGetMaxY(priceLabel.frame) + padding * 0.8;
    CGFloat imageScrollW = kWidth - 4 *padding;
    CGFloat imageScrollH = 108;
    UIScrollView *imageScroll = [[UIScrollView alloc]init];
    imageScroll.showsVerticalScrollIndicator = NO;
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.frame = CGRectMake(imageScrollX, imageScrollY, imageScrollW, imageScrollH);
    [backView addSubview:imageScroll];
    self.imageScrollView = imageScroll;
    
    CGFloat locationIconX = padding;
    CGFloat locationIconY = CGRectGetMaxY(imageScroll.frame) + padding ;
    CGFloat locationIconW = 20;
    CGFloat locationIconH = 20;
    UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location_list"]];
    locationIcon.frame = CGRectMake(locationIconX, locationIconY, locationIconW, locationIconH);
    [backView addSubview:locationIcon];
    
    UILabel *locationName = [[UILabel alloc] init];
    locationName.frame = CGRectMake(CGRectGetMaxX(locationIcon.frame) + padding * 0.3, locationIconY, 65, 20);
    locationName.textColor = [UIColor colorWithWhite:0.455 alpha:1.000];
    locationName.text = @"交易地点：";
    locationName.font = [UIFont systemFontOfSize:13];
    [backView addSubview:locationName];
    
    UILabel *localLabel = [[UILabel alloc] init];
    localLabel.frame = CGRectMake(CGRectGetMaxX(locationName.frame) +0 *padding, locationIconY, 100, 20);
    localLabel.textColor = [UIColor colorWithRed:0.949 green:0.652 blue:0.034 alpha:1.000];
    self.localLabel = localLabel;
    [backView addSubview:localLabel];
    
    UIView *divideLine = [[UIView alloc] init];
    divideLine.frame = CGRectMake(0, 291, 355, 1);
    divideLine.backgroundColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    divideLine.alpha = 0.3;
    //    [backView addSubview:divideLine];
    
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
    //    [backView addSubview:attentionBtn];
    
    UIButton *reviewBtn = [[UIButton alloc] init];
    reviewBtn.frame = CGRectMake(attentionBtnX + 125, attentionBtnY, attentionBtnW, attentionBtnH);
    [reviewBtn setImage:[UIImage imageNamed:@"home_comment"] forState:UIControlStateNormal];
    [reviewBtn setTitle:@"13" forState:UIControlStateNormal];
    reviewBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    reviewBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [reviewBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    //    [backView addSubview:reviewBtn];
    
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.frame = CGRectMake(attentionBtnX + 250, attentionBtnY, attentionBtnW, attentionBtnH);
    [shareBtn setImage:[UIImage imageNamed:@"home_share"] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [shareBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    //    [backView addSubview:shareBtn];
    
}


- (void)setData
{
    
    [self.nameButton setTitle:self.goodsList.username forState:UIControlStateNormal];
    
    self.localLabel.text = @"金水区";
    self.timeLabel.text = self.goodsList.createdTime;
    self.localLabel.text = self.goodsList.locationString;
    self.descLabel.text = [self.goodsList.title stringByAppendingFormat:@"，%@",self.goodsList.text];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsList.price];
    self.iconView.image = [UIImage imageWithData:self.goodsList.iconData];
    
    
    CGFloat oneImageY = 0;
    CGFloat oneImageW = 108;
    CGFloat oneImageH = 108;
    [self.imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageScrollView.contentSize = CGSizeMake((oneImageW + 5) * self.goodsList.pictures.count, oneImageH );
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
