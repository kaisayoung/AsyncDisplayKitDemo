//
//  FamousSceneryDataManager.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "FamousSceneryDataManager.h"
#import "FamousSceneryModel.h"

@implementation FamousSceneryDataManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static FamousSceneryDataManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[FamousSceneryDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FamousScenery" ofType:@"plist"]];
    self.modelList = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        FamousSceneryModel *model = [[FamousSceneryModel alloc] initWithDict:dic];
        [self.modelList addObject:model];
    }
}

@end
