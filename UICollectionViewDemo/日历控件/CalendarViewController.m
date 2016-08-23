//
//  CalendarViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/23.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "CalendarViewController.h"
#import "SimpleCollectionViewCell.h"

@interface CalendarViewController () <UICollectionViewDataSource, UICollectionViewDelegate> {
    int weekPerMonth;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    weekPerMonth = 6;
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup collection view
- (void)setupCollectionView {
    // 注册自定义的Cell
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:mainBundle] forCellWithReuseIdentifier:cellName];
    
    // 触摸延迟
    self.collectionView.delaysContentTouches = NO;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat wd = self.collectionView.frame.size.width/7.0;
    CGFloat ht = (self.collectionView.frame.size.height - 64) / weekPerMonth;
    return CGSizeMake(wd, ht);
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 5周
    return weekPerMonth*7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    // 使用自定义Cell，也可以在StoryBoard中添加
    // 自定义的Cell耦合性较低，便于复用
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    SimpleCollectionViewCell* tCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    NSInteger row = indexPath.row % weekPerMonth;
    NSInteger col = indexPath.row / weekPerMonth;
    tCell.labelTitle.text = [NSString stringWithFormat:@"%ld, %ld", row, col];
    cell = tCell;
    
    return cell;
}

@end
