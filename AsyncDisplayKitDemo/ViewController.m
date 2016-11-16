//
//  ViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/4.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "ViewController.h"
#import "TraditionalViewController.h"
#import "SmoothViewController.h"
#import "TraditionalTableViewController.h"
#import "SmoothTableViewController.h"
#import "ExtremeTableViewController.h"
#import "TraditionalCollectionViewController.h"
#import "SmoothCollectionViewController.h"
#import "ExtremeCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToDestVC:(UIViewController *)destVC {
    [self.navigationController pushViewController:destVC animated:YES];
}

// 注意模拟器感受不出来差别
- (IBAction)onGotoControllerButtonTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
        {
            TraditionalViewController *traditionVC = [[TraditionalViewController alloc] initWithNibName:@"TraditionalViewController" bundle:nil];
            [self pushToDestVC:traditionVC];
        }
            break;
        case 1:
        {
            SmoothViewController *smoothVC = [[SmoothViewController alloc] initWithNibName:@"SmoothViewController" bundle:nil];
            [self pushToDestVC:smoothVC];
        }
            break;
        case 2:
        {
            TraditionalTableViewController *traditionalTVC = [[TraditionalTableViewController alloc] initWithNibName:@"TraditionalTableViewController" bundle:nil];
            [self pushToDestVC:traditionalTVC];
        }
            break;
        case 3:
        {
            SmoothTableViewController *smoothTVC = [[SmoothTableViewController alloc] initWithNibName:@"SmoothTableViewController" bundle:nil];
            [self pushToDestVC:smoothTVC];
        }
            break;
        case 4:
        {
            ExtremeTableViewController *extremeTVC = [[ExtremeTableViewController alloc] init];
            [self pushToDestVC:extremeTVC];
        }
            break;
        case 5:
        {
            TraditionalCollectionViewController *traditionalCVC = [[TraditionalCollectionViewController alloc] initWithNibName:@"TraditionalCollectionViewController" bundle:nil];
            [self pushToDestVC:traditionalCVC];
        }
            break;
        case 6:
        {
            SmoothCollectionViewController *smoothCVC = [[SmoothCollectionViewController alloc] initWithNibName:@"SmoothCollectionViewController" bundle:nil];
            [self pushToDestVC:smoothCVC];
        }
            break;
        case 7:
        {
            ExtremeCollectionViewController *extremeCVC = [[ExtremeCollectionViewController alloc] init];
            [self pushToDestVC:extremeCVC];
        }
            break;
        default:
            break;
    }
    
}

@end
