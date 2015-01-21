//
//  PTGoodsPhotoItem.m
//  Camser
//
//  Created by iPeta on 15/1/20.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTGoodsPhotoItem.h"

@implementation PTGoodsPhotoItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setContentImage:(UIImage *)contentImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, self.frame.size.width - 7, self.frame.size.height - 8)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = contentImage;
    [self addSubview:imageView];
    
    UIImageView *deleteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete-circular.png"]];
    deleteIcon.bounds = CGRectMake(0, 0, 15, 15);
    deleteIcon.center = CGPointMake(85, 4);
    [self addSubview:deleteIcon];
    
    UIButton *uploadBtn = [[UIButton alloc]init];
    uploadBtn.frame = imageView.frame;
    uploadBtn.backgroundColor = [UIColor grayColor];
    uploadBtn.alpha = 0.8;
    [uploadBtn setTitle:@"正在上传" forState:UIControlStateNormal];
    self.uploadBtn = uploadBtn;
    [self addSubview:uploadBtn];
    
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.bounds = CGRectMake(0, 0, 60,60);
    btnDelete.center = CGPointMake(65, 29);
    btnDelete.tag = self.index;
    [btnDelete addTarget:self
                  action:@selector(deletePhotoItem:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDelete];
}

/*
 删除图片
 */
-(void)deletePhotoItem:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(goodsPhotoItemView:didSelectDeleteButtonAtIndex:)]){
        [self.delegate goodsPhotoItemView:self didSelectDeleteButtonAtIndex:sender.tag];
    }
}

@end
