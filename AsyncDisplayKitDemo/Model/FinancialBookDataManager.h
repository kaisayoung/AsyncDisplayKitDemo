//
//  FinancialBookDataManager.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  数据管理类，用于给tableview提供数据源
 */

@interface FinancialBookDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *modelList;

+ (instancetype)sharedInstance;

@end
