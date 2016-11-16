//
//  ExtremeCollectionViewCellNode.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "ExtremeCollectionViewCellNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FamousSceneryModel.h"

@interface ExtremeCollectionViewCellNode ()<ASNetworkImageNodeDelegate>

/*
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
 */

// 原生控件和node可混用：直接使用或者将子控件套在node里
@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, strong) ASDisplayNode *activityIndicator;

@property (nonatomic, strong) ASNetworkImageNode *sceneryImageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;

@property (nonatomic, assign) BOOL isLoadFinish;

@end

@implementation ExtremeCollectionViewCellNode

#pragma mark - lifestyle

- (instancetype)init {
    self = [super init];
    if (self) {
        // create
        ASDisplayNode *activityIndicator = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicator.hidesWhenStopped = YES;
            indicator.backgroundColor = [UIColor clearColor];
            return indicator;
        }];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        ASNetworkImageNode *sceneryImageNode = [[ASNetworkImageNode alloc] init];
        ASTextNode *nameTextNode = [[ASTextNode alloc] init];
        // hierarchy
        [self addSubnode:sceneryImageNode];
        [self addSubnode:activityIndicator];
        [self.view addSubview:blurView];
        [blurView addSubview:nameTextNode.view];
        // set property
        self.sceneryImageNode = sceneryImageNode;
        self.activityIndicator = activityIndicator;
        self.blurView = blurView;
        self.nameTextNode = nameTextNode;
    }
    return self;
}

#pragma mark - public

- (void)bindDataSourceModel:(id)model {
    
    [self startAnimation];
    FamousSceneryModel *sceneryModel = (FamousSceneryModel *)model;
    
    // config
    self.sceneryImageNode.contentMode = UIViewContentModeScaleAspectFill;
    self.sceneryImageNode.delegate = self;
    self.sceneryImageNode.URL = [NSURL URLWithString:sceneryModel.photoUrl];
    self.nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:sceneryModel.name attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)resume {
    [self.nameTextNode.view removeFromSuperview];
    [self.blurView addSubview:self.nameTextNode.view];
    if(self.isLoadFinish) return;
    [self startAnimation];
}

#pragma mark - override 

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    
    [self.nameTextNode measure:CGSizeMake(constrainedSize.width, MAXFLOAT)];
    return constrainedSize;
}

- (void)layout {
    
    [super layout];
    self.sceneryImageNode.frame = CGRectMake(0, 0, self.calculatedSize.width, self.calculatedSize.height);
    self.blurView.frame = CGRectMake(0, self.calculatedSize.height - 35, self.calculatedSize.width, 35);
    self.nameTextNode.frame = [self centerRectFromSuperSize:self.blurView.frame.size subSize:self.nameTextNode.calculatedSize];
    self.activityIndicator.frame = [self centerRectFromSuperSize:self.calculatedSize subSize:CGSizeMake(37, 37)];
}

#pragma mark - private

- (void)startAnimation {
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)self.activityIndicator.view;
    if ([activityIndicatorView isKindOfClass:[UIActivityIndicatorView class]]) {
        [activityIndicatorView startAnimating];
    }
}

- (void)stopAnimation {
    self.isLoadFinish = YES;
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)self.activityIndicator.view;
    if ([activityIndicatorView isKindOfClass:[UIActivityIndicatorView class]]) {
        [activityIndicatorView stopAnimating];
    }
}

- (CGRect)centerRectFromSuperSize:(CGSize)superSize subSize:(CGSize)subSize {
    return CGRectMake((superSize.width - subSize.width) / 2.0, (superSize.height - subSize.height) / 2.0, subSize.width, subSize.height);
}

#pragma mark - ASNetworkImageNodeDelegate

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    [self stopAnimation];
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error {
    [self stopAnimation];
}

@end
