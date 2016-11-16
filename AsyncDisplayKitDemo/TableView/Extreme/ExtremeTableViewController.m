//
//  ExtremeTableViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "ExtremeTableViewController.h"
#import "ExtremeTableViewCellNode.h"
#import "FinancialBookDataManager.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "Macros.h"

@interface ExtremeTableViewController ()<ASTableDataSource,ASTableDelegate>

@property (nonatomic, strong) ASTableView *tableView;

@end

@implementation ExtremeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"extremeTVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configureTableView];
}

- (void)dealloc {
    self.tableView.asyncDataSource = nil;
    self.tableView.asyncDelegate = nil;
}

- (void)configureTableView {
    ASTableView *tableView = [[ASTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.asyncDataSource = self;
    tableView.asyncDelegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ASTableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FinancialBookDataManager sharedInstance].modelList count];
}

// 注意这里不用考虑cell的复用，因为根本就没有cell
- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExtremeTableViewCellNode *cellNode = [[ExtremeTableViewCellNode alloc] init];
    [cellNode bindDataSourceModel:[[FinancialBookDataManager sharedInstance].modelList objectAtIndex:indexPath.row]];
    return cellNode;
}

#pragma mark - ASTableDelegate

// 注意此时此方法从不会被调用
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

@end
