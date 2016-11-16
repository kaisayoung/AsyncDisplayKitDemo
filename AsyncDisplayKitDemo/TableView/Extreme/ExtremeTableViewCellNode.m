//
//  ExtremeTableViewCellNode.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "ExtremeTableViewCellNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FinancialBookModel.h"
#import "DownloadManager.h"

@interface ExtremeTableViewCellNode ()<ASNetworkImageNodeDelegate>

@property (nonatomic, strong) ASNetworkImageNode *bookImageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *authorTextNode;
@property (nonatomic, strong) ASTextNode *publisherTextNode;
@property (nonatomic, strong) ASDisplayNode *bottomLineNode;

@property (nonatomic, strong) ASDisplayNode *containerNode;

@end

@implementation ExtremeTableViewCellNode

- (instancetype)init {
    self = [super init];
    if (self) {
        // create
        ASDisplayNode *containerNode = [[ASDisplayNode alloc] init];
        ASTextNode *titleTextNode = [[ASTextNode alloc] init];
        ASTextNode *authorTextNode = [[ASTextNode alloc] init];
        ASTextNode *publisherTextNode = [[ASTextNode alloc] init];
        ASDisplayNode *bottomLineNode = [[ASDisplayNode alloc] init];
        ASNetworkImageNode *bookImageNode = [[ASNetworkImageNode alloc] initWithCache:[DownloadManager shareInstance] downloader:[DownloadManager shareInstance]];
        // hierarchy
        [containerNode addSubnode:titleTextNode];
        [containerNode addSubnode:authorTextNode];
        [containerNode addSubnode:publisherTextNode];
        [containerNode addSubnode:bottomLineNode];
        [containerNode addSubnode:bookImageNode];
        [self addSubnode:containerNode];
        // set property
        self.bookImageNode = bookImageNode;
        self.titleTextNode = titleTextNode;
        self.authorTextNode = authorTextNode;
        self.publisherTextNode = publisherTextNode;
        self.bottomLineNode = bottomLineNode;
        self.containerNode = containerNode;
    }
    return self;
}

- (void)bindDataSourceModel:(id)model {
    
    FinancialBookModel *bookModel = (FinancialBookModel *)model;
    
    // configure
    self.containerNode.shouldRasterizeDescendants = YES;
    self.titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.authorTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.author attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.publisherTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.publisher attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.bookImageNode.defaultImage = [UIImage imageNamed:@"TajMahal.jpg"];
    self.bookImageNode.contentMode = UIViewContentModeScaleAspectFill;
    self.bookImageNode.delegate = self;
    self.bookImageNode.URL = [NSURL URLWithString:bookModel.photoUrl];
    self.bottomLineNode.backgroundColor = [UIColor lightGrayColor];
    self.bookImageNode.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - override 

// 注意这里已经不需要SCREEN_WIDTH这种硬编码了，更加灵活
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    
    [self.titleTextNode measure:CGSizeMake(constrainedSize.width - 86, MAXFLOAT)];
    [self.authorTextNode measure:CGSizeMake(constrainedSize.width - 86, MAXFLOAT)];
    [self.publisherTextNode measure:CGSizeMake(constrainedSize.width - 86, MAXFLOAT)];
    return CGSizeMake(constrainedSize.width, 103);
}

- (void)layout {
    
    [super layout];
    self.containerNode.frame = CGRectMake(0, 0, self.calculatedSize.width, 103);
    self.bookImageNode.frame = CGRectMake(20, 15, 50, 72);
    self.titleTextNode.frame = CGRectMake(86, 15, self.titleTextNode.calculatedSize.width, self.titleTextNode.calculatedSize.height);
    self.authorTextNode.frame = CGRectMake(86, (self.containerNode.frame.size.height - self.authorTextNode.calculatedSize.height) / 2.0, self.authorTextNode.calculatedSize.width, self.authorTextNode.calculatedSize.height);
    self.publisherTextNode.frame = CGRectMake(86, self.containerNode.frame.size.height - self.publisherTextNode.calculatedSize.height - 15, self.publisherTextNode.calculatedSize.width, self.publisherTextNode.calculatedSize.height);
    self.bottomLineNode.frame = CGRectMake(0, self.containerNode.frame.size.height - 0.5, self.calculatedSize.width, 0.5);
}

#pragma mark - ASNetworkImageNodeDelegate

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    NSLog(@"load image finish");
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error {
    NSLog(@"load fail error is %@",error);
}

@end
