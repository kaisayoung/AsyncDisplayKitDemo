//
//  DownloadManager.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/16.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "DownloadManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloaderOperation.h>

@implementation DownloadManager

+ (instancetype)shareInstance {
    static DownloadManager *downloadManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[DownloadManager alloc] init];
    });
    return downloadManager;
}

#pragma mark - ASImageDownloaderProtocol

- (id)downloadImageWithURL:(NSURL *)URL
                      callbackQueue:(dispatch_queue_t)callbackQueue
                   downloadProgress:(nullable ASImageDownloaderProgress)downloadProgress
                         completion:(ASImageDownloaderCompletion)completion {
    id <SDWebImageOperation>operation = [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image) {
            dispatch_async(callbackQueue, ^{
                [[SDWebImageManager sharedManager] saveImageToCache:image forURL:URL];
                completion(image, nil, operation);
            });
        }
        else {
            dispatch_async(callbackQueue, ^{
                completion(nil, error, operation);
            });
        }
    }];
    return operation;
}

- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier {
    SDWebImageDownloaderOperation *operation = (SDWebImageDownloaderOperation *)downloadIdentifier;
    [operation cancel];
}

#pragma mark - ASImageCacheProtocol

- (void)cachedImageWithURL:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
                completion:(ASImageCacherCompletion)completion {
    BOOL existed = [[SDWebImageManager sharedManager] cachedImageExistsForURL:URL];
    if (existed) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:URL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                dispatch_async(callbackQueue, ^{
                    completion(image);
                });
            }
            else {
                dispatch_async(callbackQueue, ^{
                    completion(nil);
                });
            }
        }];
    }
    else {
        dispatch_async(callbackQueue, ^{
            completion(nil);
        });
    }
}

@end
