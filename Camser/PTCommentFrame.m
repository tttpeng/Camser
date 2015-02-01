//
//  PTCommentFrame.m
//  Camser
//
//  Created by iPeta on 15/1/30.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCommentFrame.h"
#import "PTComment.h"


@implementation PTCommentFrame

-(void)setGoodsComment:(PTComment *)goodsComment
{
    _goodsComment = goodsComment;
    
    CGFloat padding = 10;
    
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    CGFloat nameX = iconX + iconW +padding;
    CGFloat nameY = iconY;
    CGFloat nameW = 185;
    CGFloat nameH = iconH;
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat timeX = 295;
    CGFloat timeY = iconY;
    CGFloat timeW = 60;
    CGFloat timeH = iconH;
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    CGFloat textX = nameX;
    CGFloat textY = iconY + iconH;
    
    CGSize textMaxSize = CGSizeMake(290, MAXFLOAT);
    NSDictionary *attrs = @{NSFontAttributeName : PTTextFont};
    
    CGSize textSize =[goodsComment.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    CGSize textLabelSize = CGSizeMake(textSize.width + 10 , textSize.height + 10);
    
    _textF = CGRectMake(textX, textY, textLabelSize.width, textLabelSize.height);
    
    
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    _cellHeight = padding +textMaxY;
    NSLog(@"cell的高度：%f",_cellHeight);
    

}

@end
