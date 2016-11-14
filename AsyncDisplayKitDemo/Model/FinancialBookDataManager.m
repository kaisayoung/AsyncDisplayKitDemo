//
//  FinancialBookDataManager.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "FinancialBookDataManager.h"
#import "FinancialBookModel.h"

@implementation FinancialBookDataManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static FinancialBookDataManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[FinancialBookDataManager alloc] init];
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
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FinancialBook" ofType:@"plist"]];
    self.modelList = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        FinancialBookModel *model = [[FinancialBookModel alloc] initWithDict:dic];
        [self.modelList addObject:model];
    }
}

@end
