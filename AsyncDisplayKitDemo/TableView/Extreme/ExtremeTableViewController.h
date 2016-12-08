//
//  ExtremeTableViewController.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  应用ASDK做一个tvc，不但会改进cell内容的展示方式，而且tv继承自ASTableView
 *  更加适合于cell高度需要自适应的情况
 *  号称可以将滑动性能提升至60FPS，也就是如丝般顺滑，一点也不卡
 *  注意此时cell的高度都不会在本类中通过代理方法返回，只在cell中计算好就OK
 *  貌似还加入了神奇的智能预加载机制，和系统tableview对cell的复用不一样
 */

@interface ExtremeTableViewController : UIViewController

@end
