//
//  ExtremeCollectionViewCellNode.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

/*
 *  继承自ASCellNode
 *  主要展示cell和node混用
 */

@interface ExtremeCollectionViewCellNode : ASCellNode

- (void)bindDataSourceModel:(id)model;

- (void)resume;

@end
