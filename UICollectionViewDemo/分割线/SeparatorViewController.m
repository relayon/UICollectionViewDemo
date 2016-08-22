//
//  SeparatorViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/22.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "SeparatorViewController.h"
#import "SimpleCollectionViewCell.h"
#import "SeparatorLayout.h"

@interface SeparatorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    int num[100];
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SeparatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 100; i ++) {
        num[i] = i;
    }
    
    [self setupCollectionView];
    // 拖动
    [self setupForDrag];
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
    
    // 分割线Layout
    SeparatorLayout* layout = [SeparatorLayout new];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    CGFloat width = (self.view.frame.size.width) / 3.0f;
    layout.itemSize = CGSizeMake(width, width);
    self.collectionView.collectionViewLayout = layout;
}

#pragma mark -- setup for drag
- (void)setupForDrag {
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.collectionView addGestureRecognizer:longPress];
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:[recognizer locationInView:self.collectionView]];
            if (indexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                NSLog(@"begin");
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[recognizer locationInView:recognizer.view]];
            NSLog(@"move");
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            NSLog(@"end");
        }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            NSLog(@"cancel");
            break;
    }
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
    tCell.labelTitle.text = [NSString stringWithFormat:@"%d", num[indexPath.row]];
    cell = tCell;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    int tmp = num[sourceIndexPath.row];
    num[sourceIndexPath.row] = num[destinationIndexPath.row];
    num[destinationIndexPath.row] = tmp;
}

@end
