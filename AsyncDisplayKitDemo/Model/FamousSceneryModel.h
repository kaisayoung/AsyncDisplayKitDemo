//
//  FamousSceneryModel.h
//  AsyncDisplayKitDemo
//
//  Created by 恺撒 on 2016/11/9.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  数据模型类，用于给collectionviewcell提供数据
 */

@interface FamousSceneryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photoUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
