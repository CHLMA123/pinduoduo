//
//  NSObject+modelConvertDic.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (modelConvertDic)
- (NSDictionary *)dictionaryFromModelWithShowLog:(BOOL)show;
- (void)assginToPropertyWithDic:(NSDictionary *)dic;
@end
