//
//  SmoothCollectionViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "SmoothCollectionViewController.h"
#import "SmoothCollectionViewCell.h"
#import "FamousSceneryDataManager.h"
#import "Macros.h"

@interface SmoothCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation SmoothCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"smoothCVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.collectionView registerClass:[SmoothCollectionViewCell class] forCellWithReuseIdentifier:@"SmoothCollectionViewCell"];
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[FamousSceneryDataManager sharedInstance].modelList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SmoothCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmoothCollectionViewCell" forIndexPath:indexPath];
//    [cell bindDataSourceModel:[[FamousSceneryDataManager sharedInstance].modelList objectAtIndex:indexPath.row]];
    [cell bindDataSourceModel:[[FamousSceneryDataManager sharedInstance].modelList objectAtIndex:indexPath.row] inOperationQueue:self.operationQueue];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDTH - 1.0) / 2.0;
    CGFloat height = width * 134.0 / 200.0;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

@end
