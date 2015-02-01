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

@interface PTCommentCell ()

@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *textView;
@property (nonatomic,weak) UILabel *nameLable;

@end

@implementation PTCommentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor colorWithWhite:0.529 alpha:1.000];
        self.timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        iconView.frame = CGRectMake(0, 0, 40, 40);
        iconView.backgroundColor = [UIColor redColor];
        self.iconView = iconView;
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:nameLable];
        self.nameLable = nameLable;
        
        UILabel *textView  = [[UILabel alloc]init];
        textView.numberOfLines = 0;
        textView.frame = CGRectMake(50, 10, 140, 40);
        textView.font = PTTextFont;
        [self.contentView addSubview:textView];
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
    }
    return cell;
}

- (void)setCommentFrame:(PTCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    PTComment *comment = commentFrame.goodsComment;

    self.textView.text = comment.text;
    self.iconView.image = comment.user.imageFile;
    self.nameLable.text = comment.user.nickName;
    self.timeLabel.text = comment.createdTime;
    
    self.textView.frame = commentFrame.textF;
    self.timeLabel.frame = commentFrame.timeF;
    self.iconView.frame = commentFrame.iconF;
    self.nameLable.frame = commentFrame.nameF;

}




@end
