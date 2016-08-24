//
//  DetailViewController.m
//  MyXib
//
//  Created by SMC-MAC on 16/8/23.
//  Copyright © 2016年 wonbile. All rights reserved.
//

#import "DetailViewController.h"
#import "MyView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    MyView* mv = [[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:nil options:nil] firstObject];
//    mv.frame = CGRectMake(100, 100, 200, 200);
//    [self.view addSubview:mv];
    
    MyView* mv = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 100, 300)];
    [self.view addSubview:mv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
