//
//  AssistantTool.m
//  objcmodeldic
//
//  Created by foscom on 16/6/1.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "AssistantTool.h"

@implementation AssistantTool

+ (void)dictionaryFromModel:(id)model
{
    
    if (model == nil) {
        NSLog(@"%@ To dic = nil",NSStringFromClass([model class]));
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    
    NSLog(@"%@ To dic = %@",NSStringFromClass([model class]),dict);
}

#pragma mark - ******************** 通过此方法打印出成员变量
+ (void)writeInfoWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@" ---2016--- %@,%@",key,[obj class]);
        
        NSString *className = NSStringFromClass([obj class]) ;
        
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] ) {
            [strM appendFormat:@"@property (nonatomic, strong) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic,   copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL %@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }
        NSLog(@"\n%@",strM);
    }];
    
}

@end
