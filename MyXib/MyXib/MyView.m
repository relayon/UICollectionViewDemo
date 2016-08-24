//
//  MyView.m
//  MyXib
//
//  Created by SMC-MAC on 16/8/23.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

@end
