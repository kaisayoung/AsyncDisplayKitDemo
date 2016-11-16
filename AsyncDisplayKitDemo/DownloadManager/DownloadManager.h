//
//  DownloadManager.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/16.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

/*
 *  应用SDWebImage代替ASDK原生的PIN去缓存和下载图片
 */

@interface DownloadManager : NSObject<ASImageDownloaderProtocol,ASImageCacheProtocol>

+ (instancetype)shareInstance;

@end
