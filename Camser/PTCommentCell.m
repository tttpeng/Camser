//
//  PTCommentCell.m
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCommentCell.h"
#import "PTCommentFrame.h"
#import "PTComment.h"
#import "PTUser.h"
#import "UIImage+MJ.h"
#import<CoreText/CoreText.h>


@interface PTCommentCell ()

@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *textView;
@property (nonatomic,weak) UILabel *nameLable;
@property (nonatomic,weak) UIView *backView;
@property (nonatomic,weak) UIImageView *backImage;
@property (nonatomic,weak) UIView *divideView;


@end

@implementation PTCommentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UIView *divideView = [[UIView alloc] init];
        divideView.backgroundColor  = [UIColor colorWithWhite:0.848 alpha:1.000];
        self.divideView  = divideView;
        [self.contentView insertSubview:divideView atIndex:0];
        
        UIView *backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = [UIColor whiteColor];
        self.backView = backgroundView;
        [self.contentView addSubview:backgroundView];
        
        UIImage *image = [UIImage resizedImageWithName:@"cm2_act_post_bg"];
        UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:image];
        self.backImage = backgroundImage;
        [backgroundView addSubview:backgroundImage];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor colorWithWhite:0.529 alpha:1.000];
         timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel = timeLabel;
        [backgroundView addSubview:timeLabel];
        
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [backgroundView addSubview:iconView];
        iconView.frame = CGRectMake(0, 0, 25, 25);
        iconView.layer.cornerRadius = iconView.frame.size.width / 2;
        iconView.layer.masksToBounds = YES;
        iconView.backgroundColor = [UIColor redColor];
        self.iconView = iconView;
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = [UIFont systemFontOfSize:13];
        [backgroundView addSubview:nameLable];
        self.nameLable = nameLable;
        
        UILabel *textView  = [[UILabel alloc]init];
        textView.numberOfLines = 0;
        textView.frame = CGRectMake(50, 10, 140, 40);
        textView.font = PTTextFont;
        textView.textColor = [UIColor colorWithWhite:0.402 alpha:1.000];
        [backgroundView addSubview:textView];
        self.textView = textView;
        
        //设置背景色

    }
    return self;
}




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"comment";
    PTCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PTCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setCommentFrame:(PTCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    PTComment *comment = commentFrame.goodsComment;

    NSRange range ;
    NSString *text;
    if (comment.replyUser.nickName) {
        text =[NSString stringWithFormat:@"回复%@：%@",comment.replyUser.nickName,comment.text];
        range = [text rangeOfString:comment.replyUser.nickName];
    }else{
        text = comment.text;
        range = NSMakeRange(0, 0);
    }
    
    
    NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString: text];
    [attributedStr01 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.289 alpha:1.000] range:range];
    UIFont *font = [UIFont fontWithName:@"Courier-Bold" size:13];
    [attributedStr01 addAttribute:NSFontAttributeName value:font range:range];
    
    self.textView.attributedText = attributedStr01;
    self.iconView.image = comment.user.imageFile;
    self.nameLable.text = comment.user.nickName;
    self.timeLabel.text = comment.createdTime;
    
    self.backView.frame = commentFrame.backF;
    self.backImage.frame =  self.backView.bounds;
    self.textView.frame = commentFrame.textF;
    self.timeLabel.frame = commentFrame.timeF;
    self.iconView.frame = commentFrame.iconF;
    self.nameLable.frame = commentFrame.nameF;
    self.divideView.frame = CGRectMake(26.5, 0, 1, commentFrame.cellHeight);
    

}




@end
