//
//  PTCommentFrame.m
//  Camser
//
//  Created by iPeta on 15/1/30.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCommentFrame.h"
#import "PTComment.h"
#import "PTUser.h"


@implementation PTCommentFrame

-(void)setGoodsComment:(PTComment *)goodsComment
{
    _goodsComment = goodsComment;
    
    CGFloat padding = 7;
    
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 25;
    CGFloat iconH = 25;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    CGFloat nameX = iconX + iconW +padding;
    CGFloat nameY = iconY;
    CGFloat nameW = 185;
    CGFloat nameH = iconH;
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat timeX = 265;
    CGFloat timeY = iconY;
    CGFloat timeW = 80;
    CGFloat timeH = iconH;
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    CGFloat textX = nameX;
    CGFloat textY = iconY + iconH + 3;
    
    CGSize textMaxSize = CGSizeMake(290, MAXFLOAT);
    UIFont *font = [UIFont fontWithName:@"Courier-Bold" size:13];
    NSDictionary *attrs = @{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor colorWithWhite:0.289 alpha:1.000]};

    NSString *text;
    if (goodsComment.replyUser.nickName) {
        text =[NSString stringWithFormat:@"回复%@：%@",goodsComment.replyUser.nickName,goodsComment.text];
    }else{
        text = goodsComment.text;
    }
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    CGSize textLabelSize = CGSizeMake(textSize.width , textSize.height + 13);
    
    _textF = CGRectMake(textX, textY, textLabelSize.width, textLabelSize.height);
    
    
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    
    
    CGFloat backX = 10;
    CGFloat backY = 4;
    CGFloat backW =  355;
    CGFloat backH = padding + textMaxY + padding;
    _backF = CGRectMake(backX, backY, backW, backH);
    
    _cellHeight = backH + 8;
    
    
}

@end
