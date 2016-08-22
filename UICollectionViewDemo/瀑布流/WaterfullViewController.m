//
//  WaterfullViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "WaterfullViewController.h"
#import "SimpleCollectionViewCell.h"
#import "WaterfullLayout.h"

@interface WaterfullViewController ()<WaterfullLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    int height[100];
    int _width;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation WaterfullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 100; i++) {
        height[i] = arc4random_uniform(200) + 40;
    }
    
    
    [self setupCollectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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
    
    // 布局
    WaterfullLayout* layout = [WaterfullLayout new];
    layout.columnNumber = 3;
    layout.delegate = self;
    layout.padding = 5;
    layout.edgeInsets = UIEdgeInsetsMake(5, 5, 20, 5);
    self.collectionView.collectionViewLayout = layout;
}

#pragma mark - layout的代理事件

- (CGFloat)waterfullHeightForItemAtIndex:(NSIndexPath *)indexPath {
    return height[indexPath.row];
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
    tCell.labelTitle.text = [NSString stringWithFormat:@"%d", height[indexPath.row]];
    cell = tCell;
    
    return cell;
}

@end
