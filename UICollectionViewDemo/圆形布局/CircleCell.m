//
//  CircleCell.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/24.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

- (void)awakeFromNib {
    self.contentView.layer.cornerRadius = 35.0;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

@end
