//
//  ExtremeCollectionViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "ExtremeCollectionViewController.h"
#import "ExtremeCollectionViewCellNode.h"
#import "FamousSceneryDataManager.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "Macros.h"

@interface ExtremeCollectionViewController ()<ASCollectionDataSource,ASCollectionDelegate>

@property (nonatomic, strong) ASCollectionView *collectionView;

@end

@implementation ExtremeCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"extremeCVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configureCollectionView];
}

- (void)dealloc {
    self.collectionView.asyncDataSource = nil;
    self.collectionView.asyncDelegate = nil;
}

- (void)configureCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 1.0;
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat width = (SCREEN_WIDTH - 1.0) / 2.0;
    CGFloat height = width * 134.0 / 200.0;
    // 根据是否是固定大小决定是否涉设置这个属性
    flowLayout.itemSize = CGSizeMake(width, height);
    ASCollectionView *collectionView = [[ASCollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor blackColor];
    collectionView.asyncDataSource = self;
    collectionView.asyncDelegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - ASCollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[FamousSceneryDataManager sharedInstance].modelList count];
}

// 注意此方法只会发生和cell相等数量的次数，也就是有缓存机制
- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExtremeCollectionViewCellNode *cellNode = [[ExtremeCollectionViewCellNode alloc] init];
    [cellNode bindDataSourceModel:[[FamousSceneryDataManager sharedInstance].modelList objectAtIndex:indexPath.row]];
    return cellNode;
}

#pragma mark - ASCollectionDelegate

// 注意此时此方法从不会被调用
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeZero;
}

- (void)collectionView:(ASCollectionView *)collectionView willDisplayNodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExtremeCollectionViewCellNode *cellNode = (ExtremeCollectionViewCellNode *)[collectionView nodeForItemAtIndexPath:indexPath];
    [cellNode resume];
}

@end
