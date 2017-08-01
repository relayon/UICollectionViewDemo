//
//  DiffWidthViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "DiffWidthViewController.h"
#import "SimpleCollectionViewCell.h"
#import "DiffWidthLayout.h"

@interface DiffWidthViewController ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    int width[100];
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)onValueChanged:(UISegmentedControl *)sender;

@property (weak, nonatomic) DiffWidthLayout* diffLayout;

@end

@implementation DiffWidthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 100; i++) {
        width[i] = arc4random_uniform(100) + 40;
    }
    
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tWidth = width[indexPath.row];
    return CGSizeMake(tWidth, 55);
}

#pragma mark - setup collection view
- (void)setupCollectionView {
    // 注册自定义的Cell
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:mainBundle] forCellWithReuseIdentifier:cellName];
    
    // 触摸延迟
    self.collectionView.delaysContentTouches = NO;
    
    // 布局
    DiffWidthLayout* layout = [DiffWidthLayout new];
    self.diffLayout = layout;
    layout.cellAlign = CellAlign_Left;
    self.collectionView.collectionViewLayout = layout;
    
//    [self.collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
//    self.collectionView.collectionViewLayout = [UICollectionViewFlowLayout new];
//    CGSize sz = self.collectionView.collectionViewLayout.collectionViewContentSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

#pragma mark -- delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    SimpleCollectionViewCell* tCell = (SimpleCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    tCell.bSelected = !tCell.bSelected;
    
    if (tCell.bSelected) {
        tCell.backgroundColor = [UIColor blueColor];
    } else {
        tCell.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor lightGrayColor];
//    cell.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:248.0/255.0 alpha:1.0];
    cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.8];
//    NSLog(@"------- didHighlightItemAtIndexPath");
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:1];
//    NSLog(@"------- didUnhighlightItemAtIndexPath");
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    // 使用自定义Cell，也可以在StoryBoard中添加
    // 自定义的Cell耦合性较低，便于复用
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    SimpleCollectionViewCell* tCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
//    [tCell setTransform:CGAffineTransformMakeScale(-1, 1)];
    tCell.labelTitle.text = [NSString stringWithFormat:@"%d", width[indexPath.row]];
    cell = tCell;
    tCell.layer.masksToBounds = YES;
    tCell.layer.cornerRadius = 25;
    
    if (tCell.bSelected) {
        tCell.backgroundColor = [UIColor blueColor];
    } else {
        tCell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.diffLayout.cellAlign = CellAlign_Default;
    } else if (sender.selectedSegmentIndex == 1) {
        self.diffLayout.cellAlign = CellAlign_Left;
    } else if (sender.selectedSegmentIndex == 2) {
        self.diffLayout.cellAlign = CellAlign_Right;
    }
    [self.collectionView reloadData];
}
@end
