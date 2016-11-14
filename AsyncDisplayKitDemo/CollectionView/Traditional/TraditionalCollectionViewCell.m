//
//  TraditionalCollectionViewCell.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "TraditionalCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FamousSceneryModel.h"

@interface TraditionalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sceneryImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation TraditionalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindDataSourceModel:(id)model {
    [_activityIndicator startAnimating];
    FamousSceneryModel *sceneryModel = (FamousSceneryModel *)model;
    _nameLabel.text = sceneryModel.name;
    __weak typeof(self) weakSelf = self;
    [self.sceneryImageView sd_setImageWithURL:[NSURL URLWithString:sceneryModel.photoUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        typeof(self) strongSelf = weakSelf;
        [strongSelf.activityIndicator stopAnimating];
    }];
}

@end
