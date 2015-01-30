//
//  PTCommentCell.m
//  Camser
//
//  Created by iPeta on 15/1/29.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCommentCell.h"

@interface PTCommentCell ()

@property (nonatomic,weak) UILabel *timeView;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UIButton *textView;

@end

@implementation PTCommentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        iconView.frame = CGRectMake(0, 0, 40, 40);
        iconView.backgroundColor = [UIColor redColor];
        self.iconView = iconView;
        
        UIButton *textView  = [[UIButton alloc]init];
        textView.titleLabel.numberOfLines = 0;
        textView.backgroundColor = [UIColor redColor];
        textView.frame = CGRectMake(50, 10, 140, 40);
//        textView.titleLabel.font = PTTextFont;
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
    static NSString *ID = @"message";
    PTCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PTCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


//
//- (void)setMessageFrame:(PTMessageFrame *)messageFrame
//{
//    _messageFrame = messageFrame;
//    
//    PTMessage *message = messageFrame.message;
//    //时间
//    self.timeView.text = message.time;
//    self.timeView.frame = messageFrame.timeF;
//    
//    
//    NSString *icon = message.type == PTMessageTypeMe ? @"me" : @"other";
//    self.iconView.image = [UIImage imageNamed:icon];
//    self.iconView.frame = messageFrame.iconF;
//    
//    [self.textView setTitle:message.text forState:UIControlStateNormal];
//    self.textView.frame = messageFrame.textF;
//    
//    //正文的背景
//    if (message.type == PTMessageTypeMe) {
//        
//        UIImage *lastNormal = [UIImage resizableImage:@"chat_send_nor"];
//        
//        [self.textView setBackgroundImage:lastNormal forState:UIControlStateNormal];
//    }else
//    {
//        UIImage *lastNormal = [UIImage resizableImage:@"chat_recive_nor"];
//        [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:lastNormal forState:UIControlStateNormal];
//    }
//}




@end
