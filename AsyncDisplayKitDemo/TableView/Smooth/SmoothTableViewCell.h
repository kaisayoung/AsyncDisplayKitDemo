//
//  SmoothTableViewCell.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  应用ASDK做一个cell，此时最好纯代码
 *  精髓在于：在后台线程做显示前的准备工作，一切就绪后再在主线程显示；准备重用或被销毁时取消
 *  没有使用SDWebImage做图片异步下载和缓存，使用ASDK默认的PIN...
 *  注意两个方法的区别，线程切换
 */

@interface SmoothTableViewCell : UITableViewCell

//- (void)bindDataSourceModel:(id)model;

- (void)bindDataSourceModel:(id)model inOperationQueue:(NSOperationQueue *)operationQueue;

@end
