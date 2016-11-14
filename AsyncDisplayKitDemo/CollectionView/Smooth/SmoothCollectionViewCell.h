//
//  SmoothCollectionViewCell.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/11.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  应用ASDK做一个cell，此时最好纯代码
 *  精髓在于：在后台线程做显示前的准备工作，一切就绪后再在主线程显示；准备重用或被销毁时取消
 *  注意两个方法的区别，线程切换
 */

@interface SmoothCollectionViewCell : UICollectionViewCell

//- (void)bindDataSourceModel:(id)model;

- (void)bindDataSourceModel:(id)model inOperationQueue:(NSOperationQueue *)operationQueue;

@end
