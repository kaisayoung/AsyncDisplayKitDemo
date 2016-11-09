//
//  SmoothViewController.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  应用ASDK在一个controller中创建子控件，只能够应用纯代码并且无法再应用autolayout
 *  理论上此时会提高UI流畅性与响应速度，但是注意只在设备足够慢，控件足够多，布局足够复杂，图片足够大时才显著，否则有可能适得其反
 *  展示如何应用ASDK创建最常用的(不需交互的)原生控件的替代品：ASDisplayNode，ASTextNode，ASImageNode
 *  注意其中的GCD线程切换，将尽可能多的任务转移到后台线程，使得：图片的解码，图像和文字的绘制/渲染都未占用主线程
 *  因为不需要交互，所以还可以直接使用layer，而不必要创建相应的view，可以用Reveal对比看一下效果
 */

@interface SmoothViewController : UIViewController

@end
