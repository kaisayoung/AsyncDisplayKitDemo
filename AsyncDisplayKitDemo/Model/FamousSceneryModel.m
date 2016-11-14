//
//  FamousSceneryModel.m
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "FamousSceneryModel.h"

@implementation FamousSceneryModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = [dict valueForKey:@"name"];
        self.photoUrl = [dict valueForKey:@"imageURL"];
    }
    return self;
}

@end
