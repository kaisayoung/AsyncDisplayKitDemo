//
//  FinancialBookModel.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  数据模型类，用于给tableviewcell提供数据
 */

@interface FinancialBookModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *photoUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
