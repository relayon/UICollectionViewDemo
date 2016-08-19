//
//  MoveCellViewController.m
//  UICollectionViewDemo
//
//  Created by alekye on 16/8/19.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "MoveCellViewController.h"
#import "MoveCollectionViewCell.h"

@interface MoveCellViewController () <UICollectionViewDataSource, UICollectionViewDelegate> {
    int num[100];
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MoveCellViewController

static NSString * const reuseIdentifier = @"MoveCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 100; i ++) {
        num[i] = i;
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setupForDrag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                
//                UICollectionViewCell *selectedCell = [self.collectionView cellForItemAtIndexPath:indexPath];
//                [UIView animateWithDuration:0.3f animations:^{
//                    selectedCell.transform = CGAffineTransformMakeScale(2.1f, 2.1f);
//                }];
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
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.labelTitle.text = [NSString stringWithFormat:@"%d", num[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    int tmp = num[sourceIndexPath.row];
    num[sourceIndexPath.row] = num[destinationIndexPath.row];
    num[destinationIndexPath.row] = tmp;
}

@end
