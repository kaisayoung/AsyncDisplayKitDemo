//
//  TraditionalTableViewCell.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "TraditionalTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FinancialBookModel.h"

@interface TraditionalTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation TraditionalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindDataSourceModel:(id)model {
    FinancialBookModel *bookModel = (FinancialBookModel *)model;
    _titleLabel.text = bookModel.title;
    _authorLabel.text = bookModel.author;
    _publisherLabel.text = bookModel.publisher;
    [_bookImageView sd_setImageWithURL:[NSURL URLWithString:bookModel.photoUrl]];
}

@end
