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

@interface PTCommentCell ()

@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *textView;

@end

@implementation PTCommentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor greenColor];
        self.timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel   ];
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        iconView.frame = CGRectMake(0, 0, 40, 40);
        iconView.backgroundColor = [UIColor redColor];
        self.iconView = iconView;
        
        UILabel *textView  = [[UILabel alloc]init];
        textView.numberOfLines = 0;
        textView.backgroundColor = [UIColor cyanColor];
        textView.frame = CGRectMake(50, 10, 140, 40);
        textView.font = PTTextFont;
//        textView.contentEdgeInsets  = UIEdgeInsetsMake(PTTextPadding, PTTextPadding, PTTextPadding, PTTextPadding);
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //设置背景色
        self.backgroundColor = [UIColor colorWithWhite:0.031 alpha:1.000];
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
    //时间
    self.textView.text = comment.text;
    self.textView.frame = commentFrame.textF;
    self.timeLabel.frame = commentFrame.timeF;
    self.iconView.frame = commentFrame.iconF;
    
    

    
    
    //正文的背景
}




@end
