//
//  PTGoodsListCell.m
//  Camser
//
//  Created by iPeta on 15/1/18.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsListCell.h"
#import "PTGoodsList.h"


@interface PTGoodsListCell ()

@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *descLabel;
@property (nonatomic,weak) UILabel *priceLabel;
@property (nonatomic,weak) UILabel *tagLabel;
@property (nonatomic,weak) UILabel *localLabel;
@property (nonatomic,weak) UIView *divideLine;
@property (nonatomic,weak) UIButton *attentionBtn;
@property (nonatomic,weak) UIButton *reviewBtn;
@property (nonatomic,weak) UIButton *shareBtn;



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
    CGFloat iconViewH = 50;
    CGFloat iconViewW = 50;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
//    iconView.image = [UIImage imageNamed:@"ceshitouxiang"];
    iconView.layer.cornerRadius = iconView.frame.size.width / 2;
    iconView.layer.masksToBounds = YES;
    iconView.layer.borderWidth = 3.0f;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    CGFloat nameLabelX = 78;
    CGFloat nameLabelY = 25;
    CGFloat nameLabelW = 200;
    CGFloat nameLabelH = 21;
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    self.nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    
    CGFloat createTimeX = 295;
    CGFloat createTimeY = 23;
    CGFloat createTimeW = 61;
    CGFloat createTimeH = 21;
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(createTimeX, createTimeY, createTimeW, createTimeH);
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    CGFloat textX = 12;
    CGFloat textY = 59;
    CGFloat textW = 350;
    CGFloat textH = 50;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(textX, textY, textW, textH);
    textLabel.numberOfLines = 2;
    self.descLabel = textLabel;
    [self.contentView addSubview:textLabel];
    
    
    CGFloat priceLabelX = 60;
    CGFloat priceLabelY = 112;
    CGFloat priceLabelW = 70;
    CGFloat priceLabelH = 21;
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    self.priceLabel = priceLabel;
    [self.contentView addSubview:priceLabel];
    
    CGFloat tagLabelX =12 ;
    CGFloat tagLabelY =112 ;
    CGFloat tagLabelW =35 ;
    CGFloat tagLabelH =21 ;
    
    UILabel *tagLabel =[[UILabel alloc] init];
    tagLabel.frame = CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH);
    tagLabel.backgroundColor = [UIColor colorWithRed:0.161 green:0.659 blue:0.537 alpha:1.000];
    self.tagLabel = tagLabel;
    [self.contentView addSubview:tagLabel];
    

    CGFloat imageScrollX = 12;
    CGFloat imageScrollY = 141;
    CGFloat imageScrollW = 363;
    CGFloat imageScrollH = 105;

    UIScrollView *imageScroll = [[UIScrollView alloc]init];
    imageScroll.showsVerticalScrollIndicator = NO;
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.frame = CGRectMake(imageScrollX, imageScrollY, imageScrollW, imageScrollH);
    imageScroll.contentSize = CGSizeMake(440, imageScrollH);
    [self.contentView addSubview:imageScroll];
    
    
    CGFloat oneImageX = 0;
    CGFloat oneImageY = 0;
    CGFloat oneImageW = 105;
    CGFloat oneImageH = 105;
    for (int i = 0 ; i < 4; i ++) {
        UIImageView *oneImage = [[UIImageView alloc] init];
        oneImage.contentMode = UIViewContentModeScaleAspectFill;
        oneImage.backgroundColor = [UIColor redColor];
        oneImage.frame = CGRectMake((oneImageW + 5) * i, oneImageY, oneImageW, oneImageH);
        NSString *imageName = [NSString stringWithFormat:@"IMG_00%d",i + 95];
        oneImage.image = [UIImage imageNamed:imageName];

        [imageScroll addSubview:oneImage];
    }
  

    
    UILabel *localLabel = [[UILabel alloc] init];
    localLabel.frame = CGRectMake(12, 253, 61, 30);
    localLabel.backgroundColor = [UIColor colorWithWhite:0.557 alpha:1.000];
    self.localLabel = localLabel;
    [self.contentView addSubview:localLabel];
    

    UIView *divideLine = [[UIView alloc] init];
    divideLine.frame = CGRectMake(0, 291, 375, 1);
    divideLine.backgroundColor = [UIColor colorWithWhite:0.557 alpha:1.000];
    divideLine.alpha = 0.5;
    [self.contentView addSubview:divideLine];
    
    CGFloat attentionBtnX = 0;
    CGFloat attentionBtnY = 291;
    CGFloat attentionBtnW = 125;
    CGFloat attentionBtnH = 44;
    
    UIButton *attentionBtn = [[UIButton alloc] init];
    attentionBtn.frame = CGRectMake(attentionBtnX, attentionBtnY, attentionBtnW, attentionBtnH);
    [attentionBtn setImage:[UIImage imageNamed:@"xiaoxin"] forState:UIControlStateNormal];
    [attentionBtn setTitle:@"4" forState:UIControlStateNormal];
    [attentionBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:attentionBtn];
    
    UIButton *reviewBtn = [[UIButton alloc] init];
    reviewBtn.frame = CGRectMake(attentionBtnX + 125, attentionBtnY, attentionBtnW, attentionBtnH);
    [reviewBtn setImage:[UIImage imageNamed:@"xiaoxin"] forState:UIControlStateNormal];
    [reviewBtn setTitle:@"13" forState:UIControlStateNormal];
    [reviewBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:reviewBtn];
    
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.frame = CGRectMake(attentionBtnX + 250, attentionBtnY, attentionBtnW, attentionBtnH);
    [shareBtn setImage:[UIImage imageNamed:@"xiaoxin"] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor colorWithWhite:0.557 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:shareBtn];
    
    
    
    
}


- (void)setData
{
    self.localLabel.text = @"金水区";
    self.nameLabel.text = self.goodsList.username;
    self.timeLabel.text = @"5分钟前";
    self.descLabel.text = self.goodsList.text;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsList.price];
    self.tagLabel.text = @"想卖";
    self.iconView.image = [UIImage imageWithData:self.goodsList.iconData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
