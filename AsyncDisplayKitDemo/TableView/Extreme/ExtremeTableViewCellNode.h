//
//  ExtremeTableViewCellNode.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

/*
 *  继承自ASCellNode，子内容均是node
 *  竟然会有几张图片不显示，我擦了
 */

@interface ExtremeTableViewCellNode : ASCellNode

- (void)bindDataSourceModel:(id)model;

@end
