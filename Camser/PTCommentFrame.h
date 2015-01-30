//
//  PTCommentFrame.h
//  Camser
//
//  Created by iPeta on 15/1/30.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#define PTTextFont [UIFont systemFontOfSize:13]
#define PTTextPadding 20
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class PTComment;
@interface PTCommentFrame : NSObject

@property(nonatomic,strong)PTComment *goodsComment;
@property (nonatomic,assign,readonly) CGRect textF;
@property (nonatomic,assign,readonly) CGRect iconF;
@property (nonatomic,assign,readonly) CGRect timeF;
@property (nonatomic,assign,readonly) CGRect nameF;
@property (nonatomic,assign,readonly) CGFloat cellHeight;

@end
