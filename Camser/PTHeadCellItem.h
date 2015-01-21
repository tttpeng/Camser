//
//  PTHeadCellItem.h
//  Camser
//
//  Created by iPeta on 15/1/16.
//  Copyright (c) 2015年 彭涛. All rights reserved.
//

#import "PTCellItem.h"

@interface PTHeadCellItem : PTCellItem

@property (nonatomic,assign) Class destVcClass;


+ (instancetype)itemWithIcon:(NSData *)icon title:(NSString *)title backIamge:(NSString *)backImage destVcClass:(Class)destVcClass;
@end
