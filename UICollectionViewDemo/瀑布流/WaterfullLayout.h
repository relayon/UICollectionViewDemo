//
//  WaterfullLayout.h
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterfullLayoutDelegate <NSObject>
// cell的高度
- (CGFloat)waterfullHeightForItemAtIndex:(NSIndexPath *)indexPath;
@end

@interface WaterfullLayout : UICollectionViewFlowLayout

// 列数
@property (nonatomic, assign) NSInteger columnNumber;

// 间隔
@property (nonatomic, assign) CGFloat padding;

// 集合视图整体的边距
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

// 代理
@property (nonatomic, weak) id <WaterfullLayoutDelegate> delegate;

@end
