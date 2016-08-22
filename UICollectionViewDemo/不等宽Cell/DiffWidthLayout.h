//
//  DiffWidthLayout.h
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellAlign) {
    CellAlign_Default,  // 默认
    CellAlign_Left,     // 左对齐
    CellAlign_Right,    // 右对齐
};

/**
 *   TODO:// 右对齐没有实现
 */
@interface DiffWidthLayout : UICollectionViewFlowLayout

// 最大间隔，默认15.0f
@property (nonatomic) CGFloat maximumInteritemSpacing;

@property (nonatomic) CellAlign cellAlign;

@end
