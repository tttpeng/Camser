//
//  PTGoodsPhotoItem.h
//  Camser
//
//  Created by iPeta on 15/1/20.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTGoodsPhotoItem;

@protocol PTGoodsPhotoItemDelegate <NSObject>

- (void)goodsPhotoItemView:(PTGoodsPhotoItem *)goodsPhotoItem didSelectDeleteButtonAtIndex:(NSInteger)index;

@end
@interface PTGoodsPhotoItem : UIView

@property (nonatomic,weak)id<PTGoodsPhotoItemDelegate>delegate;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)UIImage *contentImage;
@property (nonatomic,weak)UIButton *uploadBtn;

@end
