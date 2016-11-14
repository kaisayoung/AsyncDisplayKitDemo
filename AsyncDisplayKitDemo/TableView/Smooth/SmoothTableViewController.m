//
//  SmoothTableViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "SmoothTableViewController.h"
#import "SmoothTableViewCell.h"
#import "FinancialBookDataManager.h"
#import "Macros.h"

@interface SmoothTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation SmoothTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"smoothTVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.tableView registerClass:[SmoothTableViewCell class] forCellReuseIdentifier:@"SmoothTableViewCell"];
}

- (void)initSubview {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
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
    SmoothTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmoothTableViewCell"];
//    [cell bindDataSourceModel:[[FinancialBookDataManager sharedInstance].modelList objectAtIndex:indexPath.row]];
    [cell bindDataSourceModel:[[FinancialBookDataManager sharedInstance].modelList objectAtIndex:indexPath.row] inOperationQueue:self.operationQueue];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 103;
}

@end
