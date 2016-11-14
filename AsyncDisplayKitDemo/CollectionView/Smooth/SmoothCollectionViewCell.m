//
//  SmoothCollectionViewCell.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "SmoothCollectionViewCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FamousSceneryModel.h"
#import "Macros.h"

@interface SmoothCollectionViewCell ()<ASNetworkImageNodeDelegate>

/*
 @property (weak, nonatomic) IBOutlet UIImageView *sceneryImageView;
 @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
 */

// 此两个控件node并不支持，所以只能用view
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIVisualEffectView *blurView;
// 原生控件和node可以混用
@property (nonatomic, strong) ASNetworkImageNode *sceneryImageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;

@property (nonatomic, strong) NSOperation *constructionOperation;

// 这里也多加了两个尺寸变量
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGSize blurSize;

@end

@implementation SmoothCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.cellSize = frame.size;
        [self createSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.constructionOperation) {
        [self.constructionOperation cancel];
    }
    self.sceneryImageNode.displaySuspended = YES;
    [self.sceneryImageNode.view removeFromSuperview];
    self.sceneryImageNode = nil;
    [self.nameTextNode.view removeFromSuperview];
    self.nameTextNode = nil;
    [self.activityIndicator removeFromSuperview];
    [self.blurView removeFromSuperview];
}

- (void)createSubViews {
    // create
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    // config
    self.activityIndicator.hidesWhenStopped = YES;
    // layout
    self.activityIndicator.frame = [self centerRectFromSuperSize:self.cellSize subSize:CGSizeMake(37, 37)];
    self.blurView.frame = CGRectMake(0, self.cellSize.height - 35, self.cellSize.width, 35);
    self.blurSize = self.blurView.frame.size;
    // hierarchy
}

- (void)bindDataSourceModel:(id)model inOperationQueue:(NSOperationQueue *)operationQueue {
    self.constructionOperation = [self bindDataSourceModel:model];
    [operationQueue addOperation:self.constructionOperation];
}

// 注意这里出现了cellSize的硬编码
- (NSOperation *)bindDataSourceModel:(id)model {
    
    [self.activityIndicator startAnimating];
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    [blockOperation addExecutionBlock:^{
        if ([weakSelf.constructionOperation isCancelled]) return;
        FamousSceneryModel *sceneryModel = (FamousSceneryModel *)model;
        // create
        ASNetworkImageNode *sceneryImageNode = [[ASNetworkImageNode alloc] init];
        ASTextNode *nameTextNode = [[ASTextNode alloc] init];
        // config
        sceneryImageNode.contentMode = UIViewContentModeScaleAspectFill;
        sceneryImageNode.delegate = weakSelf;
        sceneryImageNode.URL = [NSURL URLWithString:sceneryModel.photoUrl];
        nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:sceneryModel.name attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        // layout
        sceneryImageNode.frame = CGRectMake(0, 0, weakSelf.cellSize.width, weakSelf.cellSize.height);
        [nameTextNode measure:CGSizeMake(weakSelf.blurSize.width, MAXFLOAT)];
        nameTextNode.frame = [weakSelf centerRectFromSuperSize:weakSelf.blurSize subSize:nameTextNode.calculatedSize];
        // hierarchy
        typeof(self) strongSelf = weakSelf;
        // must in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([strongSelf.constructionOperation isCancelled]) return;
            [strongSelf addSubview:sceneryImageNode.view];
            [strongSelf addSubview:strongSelf.activityIndicator];
            [strongSelf addSubview:strongSelf.blurView];
            [strongSelf.blurView addSubview:nameTextNode.view];
            strongSelf.sceneryImageNode = sceneryImageNode;
            strongSelf.nameTextNode = nameTextNode;
        });
    }];
    return blockOperation;
}

- (CGRect)centerRectFromSuperSize:(CGSize)superSize subSize:(CGSize)subSize {
    return CGRectMake((superSize.width - subSize.width) / 2.0, (superSize.height - subSize.height) / 2.0, subSize.width, subSize.height);
}

#pragma mark - ASNetworkImageNodeDelegate 

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    [self.activityIndicator stopAnimating];
}

@end
