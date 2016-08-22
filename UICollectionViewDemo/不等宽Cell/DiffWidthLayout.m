//
//  DiffWidthLayout.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "DiffWidthLayout.h"

@implementation DiffWidthLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maximumInteritemSpacing = 15.0f;
        self.cellAlign = CellAlign_Default;
    }
    return self;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    
    if (self.cellAlign == CellAlign_Left) {
        //第0个cell没有上一个cell，所以从1开始
        for(int i = 1; i < [attributes count]; ++i) {
            //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
            UICollectionViewLayoutAttributes *curAttr = attributes[i];
            UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
            
            NSInteger origin = CGRectGetMaxX(preAttr.frame);
            //根据  maximumInteritemSpacing 计算出的新的 x 位置
            CGFloat targetX = origin + self.maximumInteritemSpacing;
            // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
            if (CGRectGetMinX(curAttr.frame) > targetX) {
                // 换行时不用调整
                if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                    CGRect frame = curAttr.frame;
                    frame.origin.x = targetX;
                    curAttr.frame = frame;
                }
            }
        }
    } else if (self.cellAlign == CellAlign_Right) {
        
    }
    
    
    return attributes;
}

@end
