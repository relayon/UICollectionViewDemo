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
    self.collectionView.collectionViewLayout = layout;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    // 使用自定义Cell，也可以在StoryBoard中添加
    // 自定义的Cell耦合性较低，便于复用
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    SimpleCollectionViewCell* tCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    tCell.labelTitle.text = [NSString stringWithFormat:@"%d", width[indexPath.row]];
    cell = tCell;
    
    return cell;
}

@end
