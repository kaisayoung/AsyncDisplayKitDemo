//
//  TraditionalViewController.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  传统模式在一个controller中创建子控件，应用xib与否不影响运行时的UI流畅性与响应速度
 *  创建几个最常用的(不需交互的)控件：UIView，UILabel，UIImageView
 *  如果是模拟器的话，最好用iPhone7运行看效果，会好看些，因为没对所有机型做UI适配
 */

@interface TraditionalViewController : UIViewController

@end
