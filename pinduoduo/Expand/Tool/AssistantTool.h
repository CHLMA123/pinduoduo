//
//  AssistantTool.h
//  objcmodeldic
//
//  Created by foscom on 16/6/1.
//  Copyright © 2016年 foscam. All rights reserved.
//
/**
 *  可以将该工具类头文件放入pch文件,同时在全局宏定义的头文件中定义 eg:#define showModelContent(model) [AssistantTool dictionaryFromModel:model]
 *
 *  @return 0
 */
#import <Foundation/Foundation.h>
#import  <objc/runtime.h>
@interface AssistantTool : NSObject

// 数据模型转字典 输出数据模型 方便调试
+ (void)dictionaryFromModel:(id)model;

@end
