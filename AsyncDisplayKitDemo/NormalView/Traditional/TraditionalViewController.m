//
//  TraditionalViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "TraditionalViewController.h"

@interface TraditionalViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation TraditionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"traditionalVC";
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
