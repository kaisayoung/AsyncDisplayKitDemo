//
//  SmoothViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "SmoothViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "Macros.h"

#define BottomViewHeight 320

@interface SmoothViewController ()

/*
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
 */

@property (nonatomic, strong) ASDisplayNode *topNode;
@property (nonatomic, strong) ASDisplayNode *bottomNode;
@property (nonatomic, strong) ASDisplayNode *containerNode;
@property (nonatomic, strong) ASImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *detailTextNode;

@end

@implementation SmoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"smoothVC";
    [self addDisplayContentNodeAsynchronously];
}

- (void)addDisplayContentNodeAsynchronously {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self createDisplayContentNodes];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 一旦调用了node的layer或者view属性，以后就都只能在主线程访问了
            // layer比view更加轻量级，性能更优
            [self.view.layer addSublayer:self.topNode.layer];
            [self.view.layer addSublayer:self.bottomNode.layer];
        });
    });
}

- (void)createDisplayContentNodes {
    // create
    self.topNode = [[ASDisplayNode alloc] init];
    self.bottomNode = [[ASDisplayNode alloc] init];
    self.containerNode = [[ASDisplayNode alloc] init];
    self.imageNode = [[ASImageNode alloc] init];
    self.titleTextNode = [[ASTextNode alloc] init];
    self.detailTextNode = [[ASTextNode alloc] init];
    // configure
    self.topNode.backgroundColor = [UIColor whiteColor];
    self.bottomNode.backgroundColor = [UIColor whiteColor];
    self.containerNode.backgroundColor = [UIColor whiteColor];
    self.imageNode.image = [UIImage imageNamed:@"TajMahal.jpg"];
    self.titleTextNode.attributedText = [self titleAttributedTextWithString:@"Taj Mahal"];
    self.detailTextNode.attributedText = [self detailAttributedTextWithString:@"泰姬陵（Taj Mahal ），是印度知名度最高的古迹之一，世界文化遗产，被评选为“世界新七大奇迹”。\n泰姬陵全称为“泰姬·玛哈尔陵”，是一座白色大理石建成的巨大陵墓清真寺，是莫卧儿皇帝沙贾汗为纪念他心爱的妃子于1631年至1653年在阿格拉而建的。位于今印度距新德里200多公里外的北方邦的阿格拉(Agra)城内，亚穆纳河右侧。由殿堂、钟楼、尖塔、水池等构成，全部用纯白色大理石建筑，用玻璃、玛瑙镶嵌，具有极高的艺术价值。\n泰姬陵是印度穆斯林艺术最完美的瑰宝，是世界遗产中的经典杰作之一，被誉为“完美建筑”，又有“印度明珠”的美誉。"];
    self.topNode.layerBacked = YES;
    self.bottomNode.layerBacked = YES;
    self.containerNode.layerBacked = YES;
    self.imageNode.layerBacked = YES;
    self.titleTextNode.layerBacked = YES;
    self.detailTextNode.layerBacked = YES;
    // layout
    self.topNode.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - BottomViewHeight);
    self.bottomNode.frame = CGRectMake(0, SCREEN_HEIGHT - BottomViewHeight, SCREEN_WIDTH, BottomViewHeight);
    [self.imageNode measure:self.topNode.frame.size];
    [self.titleTextNode measure:self.imageNode.calculatedSize];
    [self.detailTextNode measure:CGSizeMake(self.bottomNode.frame.size.width - 30, self.bottomNode.frame.size.height)];
    self.containerNode.frame = [self centerRectFromSuperSize:self.topNode.frame.size subSize:self.imageNode.calculatedSize];
    self.imageNode.frame = [self imageRectFromSuperSize:self.containerNode.frame.size imageSize:self.imageNode.calculatedSize];
    self.titleTextNode.frame = [self titleRectFromSuperSize:self.containerNode.frame.size titleSize:self.titleTextNode.calculatedSize];
    self.detailTextNode.frame = [self detailRectFromSuperSize:self.bottomNode.frame.size detailSize:self.detailTextNode.calculatedSize];
    // hierarchy
    [self.topNode addSubnode:self.containerNode];
    [self.containerNode addSubnode:self.imageNode];
    [self.containerNode addSubnode:self.titleTextNode];
    [self.bottomNode addSubnode:self.detailTextNode];
}

// tool method
- (NSAttributedString *)titleAttributedTextWithString:(NSString *)title {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:21], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    return attrString;
}

- (NSAttributedString *)detailAttributedTextWithString:(NSString *)detail {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:detail attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor], NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]}];
    return attrString;
}

- (CGRect)centerRectFromSuperSize:(CGSize)superSize subSize:(CGSize)subSize {
    return CGRectMake((superSize.width - subSize.width) / 2.0, (superSize.height - subSize.height) / 2.0, subSize.width, subSize.height);
}

- (CGRect)imageRectFromSuperSize:(CGSize)superSize imageSize:(CGSize)imageSize {
    return CGRectMake(0, 0, imageSize.width, imageSize.height);
}

- (CGRect)titleRectFromSuperSize:(CGSize)superSize titleSize:(CGSize)titleSize {
    return CGRectMake(8, superSize.height - titleSize.height - 8.5, titleSize.width, titleSize.height);
}

- (CGRect)detailRectFromSuperSize:(CGSize)superSize detailSize:(CGSize)detailSize {
    return CGRectMake(15, (superSize.height - detailSize.height) / 2.0, superSize.width - 30, detailSize.height);
}

@end
