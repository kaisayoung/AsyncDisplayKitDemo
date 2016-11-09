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

- (IBAction)onGotoVCButtonTapped:(id)sender {
    BOOL chooseValue = NO;
    if (chooseValue) {
        TraditionalViewController *traditionVC = [[TraditionalViewController alloc] initWithNibName:@"TraditionalViewController" bundle:nil];
        [self pushToDestVC:traditionVC];
    }
    else {
        SmoothViewController *smoothVC = [[SmoothViewController alloc] initWithNibName:@"SmoothViewController" bundle:nil];
        [self pushToDestVC:smoothVC];
    }
}

@end
