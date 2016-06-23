//
//  NSObject+modelConvertDic.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "NSObject+modelConvertDic.h"
#import <objc/runtime.h>
@implementation NSObject (modelConvertDic)

- (NSDictionary *)dictionaryFromModelWithShowLog:(BOOL)show
{
    if (self == nil) {
        
        NSLog(@"%@ To dic = nil",NSStringFromClass([self class]));
        return nil;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([self class]);
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
        id valueObject = [self valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [self valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    
    if (show) {
        NSLog(@"%@ To dic = %@",NSStringFromClass([self class]),dict);
    }
    return dict;
}


- (void)assginToPropertyWithDic:(NSDictionary *)dic
{
    
    if (dic == nil) {
        return;
    }
    
    NSArray *keys = [dic allKeys];
    for (NSInteger i = 0; i<keys.count; i++) {
        SEL setSel = [self createSetterWithPropertyName:keys[i]];
        
        if ([self respondsToSelector:setSel]) {
            
            NSString *value = [NSString stringWithFormat:@"%@",dic[keys[i]]];
            
//            [self performSelector:setSel withObject:value afterDelay:1];
//            [self setValue:value forKeyPath:keys[i]];
            [self setValue:value forKey:keys[i]];

        }
        
    }
    
}

- (SEL)createSetterWithPropertyName:(NSString *)propertyName
{
    NSMutableString *mpropertyName = [propertyName mutableCopy];
   NSString *first =  [mpropertyName substringWithRange:NSMakeRange(0, 1)];
    first = first.capitalizedString;
    [mpropertyName replaceCharactersInRange:NSMakeRange(0, 1) withString:first];
//    propertyName = propertyName.capitalizedString;
    propertyName =[NSString stringWithFormat:@"set%@:",mpropertyName];
    return NSSelectorFromString(propertyName);
}

@end
