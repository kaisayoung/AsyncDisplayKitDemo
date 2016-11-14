//
//  TraditionalTableViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "TraditionalTableViewController.h"
#import "TraditionalTableViewCell.h"
#import "FinancialBookDataManager.h"

@interface TraditionalTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TraditionalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"traditionalTVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TraditionalTableViewCell" bundle:nil] forCellReuseIdentifier:@"TraditionalTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FinancialBookDataManager sharedInstance].modelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TraditionalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TraditionalTableViewCell"];
    [cell bindDataSourceModel:[[FinancialBookDataManager sharedInstance].modelList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 103;
}

@end
