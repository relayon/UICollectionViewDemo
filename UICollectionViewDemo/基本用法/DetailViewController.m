//
//  DetailViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/19.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "DetailViewController.h"
#import "SimpleCollectionViewCell.h"
#import "SimpleSectionHeader.h"
#import "SimpleSectionFooter.h"

// 可选实现开关
#define OPTION_TAGGLE   1

/**
 *  和UITableView的用法类似，实现DataSource和Delegate协议
 */
@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置默认属性
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

/**
 *  必须要实现的DataSource方法
 */
#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 11;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    
    // 使用自定义Cell，也可以在StoryBoard中添加
    // 自定义的Cell耦合性较低，便于复用
    NSString* cellName = NSStringFromClass([SimpleCollectionViewCell class]);
    SimpleCollectionViewCell* tCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    tCell.labelTitle.text = [NSString stringWithFormat:@"{%ld, %ld}", indexPath.section, indexPath.row];
    cell = tCell;
    
    return cell;
}

/**
 *  UICollectionView的可选实现
 */
#if OPTION_TAGGLE

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 12;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // 通过storyboard设计Header 和 Footer
    // 如果需要自定义，可参考SimpleCollectionViewCell， 不同的是需要继承 UICollectionReusableView
    UICollectionReusableView* view = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString* identifier = NSStringFromClass([SimpleSectionHeader class]);
        SimpleSectionHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        header.labelTitle.text = [NSString stringWithFormat:@"Header: {%ld, %ld}", indexPath.section, indexPath.row];
        view = header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSString* identifier = NSStringFromClass([SimpleSectionFooter class]);
        SimpleSectionFooter* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        footer.labelTitle.text = [NSString stringWithFormat:@"Footer: {%ld, %ld}", indexPath.section, indexPath.row];
        view = footer;
    }
    
    return view;
}

/**
 *  iOS 9.0 以后的新功能 - 拖动
 */
// NS_AVAILABLE_IOS(9_0);
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    return YES;
}

// NS_AVAILABLE_IOS(9_0);
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    // 拖动以后，交换数据源
    
}

#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    return YES;
}

/**
 *  点击选中Cell
 *
 *  @param collectionView
 *  @param indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    // 选中后的动画
//    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.3f animations:^{
//        selectedCell.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
//    }];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s -- {%ld, %ld}", __FUNCTION__, indexPath.section, indexPath.row);
    // 取消选中后的动画
//    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.3f animations:^{
//        selectedCell.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
//    }];
}
#endif

@end
