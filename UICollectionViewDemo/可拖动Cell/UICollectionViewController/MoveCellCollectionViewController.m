//
//  MoveCellCollectionViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/19.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "MoveCellCollectionViewController.h"
#import "MoveCollectionViewCell.h"

@interface MoveCellCollectionViewController () {
    int num[100];
}

@end

@implementation MoveCellCollectionViewController

static NSString * const reuseIdentifier = @"MoveCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 100; i ++) {
        num[i] = i;
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.labelTitle.text = [NSString stringWithFormat:@"%d", num[indexPath.row]];
    
    return cell;
}

// 可定制Cell的拖动
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

// 实现此代理函数即可拖动
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    int tmp = num[sourceIndexPath.row];
    num[sourceIndexPath.row] = num[destinationIndexPath.row];
    num[destinationIndexPath.row] = tmp;
}


@end
