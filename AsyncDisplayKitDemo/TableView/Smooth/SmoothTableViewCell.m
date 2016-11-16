//
//  SmoothTableViewCell.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "SmoothTableViewCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FinancialBookModel.h"
#import "DownloadManager.h"
#import "Macros.h"

@interface SmoothTableViewCell ()

/*
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
 */

// 因为有了容器node所以做不做成成员变量都无所谓了
//@property (nonatomic, strong) ASNetworkImageNode *bookImageNode;
//@property (nonatomic, strong) ASTextNode *titleTextNode;
//@property (nonatomic, strong) ASTextNode *authorTextNode;
//@property (nonatomic, strong) ASTextNode *publisherTextNode;
//@property (nonatomic, strong) ASDisplayNode *bottomLineNode;
// 容器node
@property (nonatomic, strong) ASDisplayNode *containerNode;
@property (nonatomic, strong) NSOperation *constructionOperation;

@end

@implementation SmoothTableViewCell

// 系统会自动调用此方法初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [self.containerNode recursivelySetDisplaySuspended:YES];
    [self.containerNode.view removeFromSuperview];
    self.containerNode = nil;
}

// 注意线程切换
- (void)bindDataSourceModel:(id)model inOperationQueue:(NSOperationQueue *)operationQueue {
    self.constructionOperation = [self bindDataSourceModel:model];
    [operationQueue addOperation:self.constructionOperation];
}

// 注意这里出现一个一个103-0.5=102.5的硬编码
- (NSOperation *)bindDataSourceModel:(id)model {
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    [blockOperation addExecutionBlock:^{
        if ([weakSelf.constructionOperation isCancelled]) return;
        FinancialBookModel *bookModel = (FinancialBookModel *)model;
        // create
        ASDisplayNode *containerNode = [[ASDisplayNode alloc] init];
        ASTextNode *titleTextNode = [[ASTextNode alloc] init];
        ASTextNode *authorTextNode = [[ASTextNode alloc] init];
        ASTextNode *publisherTextNode = [[ASTextNode alloc] init];
        ASDisplayNode *bottomLineNode = [[ASDisplayNode alloc] init];
//        ASNetworkImageNode *bookImageNode = [[ASNetworkImageNode alloc] init];
        ASNetworkImageNode *bookImageNode = [[ASNetworkImageNode alloc] initWithCache:[DownloadManager shareInstance] downloader:[DownloadManager shareInstance]];
        // configure
        containerNode.shouldRasterizeDescendants = YES;
        titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
        authorTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.author attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
        publisherTextNode.attributedText = [[NSAttributedString alloc] initWithString:bookModel.publisher attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]}];
        bookImageNode.URL = [NSURL URLWithString:bookModel.photoUrl];
        bottomLineNode.backgroundColor = [UIColor lightGrayColor];
        bookImageNode.backgroundColor = [UIColor whiteColor];
        // layout
        containerNode.frame = CGRectMake(0, 0, SCREEN_WIDTH, 102.5);
        [titleTextNode measure:CGSizeMake(SCREEN_WIDTH - 86, MAXFLOAT)];
        [authorTextNode measure:CGSizeMake(SCREEN_WIDTH - 86, MAXFLOAT)];
        [publisherTextNode measure:CGSizeMake(SCREEN_WIDTH - 86, MAXFLOAT)];
        titleTextNode.frame = CGRectMake(86, 15, titleTextNode.calculatedSize.width, titleTextNode.calculatedSize.height);
        authorTextNode.frame = CGRectMake(86, (containerNode.frame.size.height - authorTextNode.calculatedSize.height) / 2.0, authorTextNode.calculatedSize.width, authorTextNode.calculatedSize.height);
        publisherTextNode.frame = CGRectMake(86, containerNode.frame.size.height - publisherTextNode.calculatedSize.height - 15, publisherTextNode.calculatedSize.width, publisherTextNode.calculatedSize.height);
        bottomLineNode.frame = CGRectMake(0, containerNode.frame.size.height - 0.5, SCREEN_WIDTH, 0.5);
        bookImageNode.frame = CGRectMake(20, 15, 50, 72);
        // hierarchy
        [containerNode addSubnode:titleTextNode];
        [containerNode addSubnode:authorTextNode];
        [containerNode addSubnode:publisherTextNode];
        [containerNode addSubnode:bottomLineNode];
        [containerNode addSubnode:bookImageNode];
        typeof(self) strongSelf = weakSelf;
        // must in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([strongSelf.constructionOperation isCancelled]) return;
            [strongSelf.contentView addSubview:containerNode.view];
            strongSelf.containerNode = containerNode;
        });
    }];
    return blockOperation;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
