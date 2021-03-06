//
//  MasterViewController.m
//  UICollectionViewDemo
//
//  Created by SMC-MAC on 16/8/19.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "MasterViewController.h"

#define K_SIMPLE_USAGE      @"基本用法"
#define K_MOVE_CONTROLLER   @"可拖动Cell（UICollectionViewController）"
#define K_MOVE_VIEW         @"可拖动Cell（UICollectionView）"
#define K_SEPARATOR_LINE    @"分割线"
#define K_DIFF_WIDTH        @"不等宽Cell"
#define K_WATERFALL         @"瀑布流"
#define K_CALENDAR          @"日历控件"
#define K_LAYOUT_CIRCLE     @"圆形布局"

@interface MasterViewController ()

@property (strong, nonatomic) NSMutableArray<NSString*>* mData;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mData = [NSMutableArray array];
    
    NSArray* items = @[K_SIMPLE_USAGE, K_MOVE_CONTROLLER, K_MOVE_VIEW, K_SEPARATOR_LINE, K_DIFF_WIDTH, K_WATERFALL, K_CALENDAR, K_LAYOUT_CIRCLE];
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
    } else if ([title isEqualToString:K_MOVE_CONTROLLER]) {
        [self performSegueWithIdentifier:@"K_MOVE_CONTROLLER" sender:self];
    } else if ([title isEqualToString:K_MOVE_VIEW]) {
        [self performSegueWithIdentifier:@"K_MOVE_VIEW" sender:self];
    } else if ([title isEqualToString:K_SEPARATOR_LINE]) {
        [self performSegueWithIdentifier:@"K_SEPARATOR_LINE" sender:self];
    } else if ([title isEqualToString:K_DIFF_WIDTH]) {
        [self performSegueWithIdentifier:@"K_DIFF_WIDTH" sender:self];
    } else if ([title isEqualToString:K_WATERFALL]) {
        [self performSegueWithIdentifier:@"K_WATERFALL" sender:self];
    } else if ([title isEqualToString:K_CALENDAR]) {
        [self performSegueWithIdentifier:@"K_CALENDAR" sender:self];
    } else if ([title isEqualToString:K_LAYOUT_CIRCLE]) {
        [self performSegueWithIdentifier:@"K_LAYOUT_CIRCLE" sender:self];
    }
}

@end
