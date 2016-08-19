//
//  MasterViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/19.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "MasterViewController.h"

#define K_SIMPLE_USAGE      @"基本用法"

@interface MasterViewController ()

@property (strong, nonatomic) NSMutableArray<NSString*>* mData;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mData = [NSMutableArray array];
    
    NSArray* items = @[K_SIMPLE_USAGE];
    [self.mData addObjectsFromArray:items];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Simple"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString* title = self.mData[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString* title = self.mData[indexPath.row];
    if ([title isEqualToString:K_SIMPLE_USAGE]) {
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        next.title = title;
        [self.navigationController pushViewController:next animated:YES];
    }
}

@end