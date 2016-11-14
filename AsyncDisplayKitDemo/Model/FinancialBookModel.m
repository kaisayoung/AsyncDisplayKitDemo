//
//  FinancialBookModel.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/10.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "FinancialBookModel.h"

@implementation FinancialBookModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.title = [dict valueForKey:@"title"];
        self.author = [dict valueForKey:@"author"];
        self.publisher = [dict valueForKey:@"publisher"];
        self.photoUrl = [dict valueForKey:@"imageURL"];
    }
    return self;
}

@end
