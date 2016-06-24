//
//  NSObject+modelConvertDic.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (modelConvertDic)

// 模型转字典
- (NSDictionary *)dictionaryFromModelWithShowLog:(BOOL)show;

// 字典转模型1
- (void)assginToPropertyWithDic:(NSDictionary *)dic;

// 字典转模型2
+ (instancetype)objectWithDict:(NSDictionary *)dict;

@end
