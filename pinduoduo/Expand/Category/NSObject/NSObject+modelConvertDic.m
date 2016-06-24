//
//  NSObject+modelConvertDic.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "NSObject+modelConvertDic.h"
#import <objc/runtime.h>

// 利用运行时（runtime）字典转模型

@implementation NSObject (modelConvertDic)

// 模型转字典
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

// 字典转模型1
- (void)assginToPropertyWithDic:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    NSArray *keys = [dic allKeys];
    for (NSInteger i = 0; i<keys.count; i++) {
        
        if ([dic[keys[i]] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *insideDic = [dic objectForKey:keys[i]];
            NSArray *keyInsideArr = [insideDic allKeys];
            for (NSInteger j = 0; j < keyInsideArr.count; j ++ )
            {
                SEL setselInside = [self createGetterWithPropertyName:keyInsideArr[j]];
                if ([self respondsToSelector:setselInside]) {

                  NSString *valueInside = [NSString stringWithFormat:@"%@",insideDic[keyInsideArr[j]]];
                  [self setValue:valueInside forKey:keyInsideArr[j]];
                }
            }

        }else{

            SEL setSel = [self createSetterWithPropertyName:keys[i]];
            if ([self respondsToSelector:setSel]) {
                NSString *value = [NSString stringWithFormat:@"%@",dic[keys[i]]];
                //[self setValue:value forKeyPath:keys[i]];
                [self setValue:value forKey:keys[i]];
            }
        }
        
    }
}

// 生成Setter方法
- (SEL)createSetterWithPropertyName:(NSString *)propertyName
{
    //propertyName = propertyName.capitalizedString; //如果有下划线 会把每个string的开头都大小 eg:abc_def :Abc_Def
    NSMutableString *mpropertyName = [propertyName mutableCopy];
    // 首字母
    //NSString *first = [mpropertyName substringWithRange:NSMakeRange(0, 1)];
    NSString *first = [mpropertyName substringToIndex:1];
    // 变大写
    first = first.capitalizedString;
    // 将大写字母调换掉原首字母
    [mpropertyName replaceCharactersInRange:NSMakeRange(0, 1) withString:first];
    // 拼接set
    ////propertyName = [mpropertyName insertString:@"set" atIndex:0];
    //// 拼接冒号:
    //[propertyName appendString:@":"];
    propertyName = [NSString stringWithFormat:@"set%@:",mpropertyName];
    return NSSelectorFromString(propertyName);
}

// 生成Getter方法
- (SEL)createGetterWithPropertyName:(NSString *)propername
{
    if (propername != nil) {
        SEL getter = NSSelectorFromString(propername);
        if ([self respondsToSelector:getter]) {
            return getter;
        }
    }
    return nil;
}

// 字典转模型2
// 实现思路: 遍历模型中所有属性,根据模型的属性名去字典中查找key,取出对应的的值,给模型的属性赋值
+ (instancetype)objectWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    //[obj setValuesForKeysWithDictionary:dict];//当字典中的键，在对象属性中找不到对应的属性的时候会报错。
    NSArray *properties = [self propertyList];
    // 遍历属性数组
    for (NSString *key in properties) {
        // 判断字典中是否包含这个key
        if (dict[key] != nil) {
            // 使用 KVC 设置数值
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    return obj;
}

+ (NSArray *)propertyList{
    
//    // 0. 判断是否存在关联对象，如果存在，直接返回 ？？
//    /**
//     1> 关联到的对象
//     2> 关联的属性 key
//
//     提示：在 OC 中，类本质上也是一个对象
//     */
//    NSArray *pList = objc_getAssociatedObject(self, propertiesKey);
//    if (pList != nil) {
//        return pList;
//    }

    // 1. 获取`类`的属性
    /**
     参数
     1> 类
     2> 属性的计数指针
     */
    unsigned int count = 0;
    // 返回值是所有属性的数组 objc_property_t。第一个参数是要获取哪个类中的成员属性,第二个参数是这个类中有多少成员属性,需要传入地址
    objc_property_t *list = class_copyPropertyList([self class], &count);

    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];

    // 遍历数组
    for (unsigned int i = 0; i < count; ++i) {
        // 获取到属性
        objc_property_t pty = list[i];

        // 获取属性的名称
        const char *cname = property_getName(pty);

        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    NSLog(@"%@", arrayM);

    // 释放属性数组
    free(list);

//    // 设置关联对象
//    /**
//     1> 关联的对象
//     2> 关联对象的 key
//     3> 属性数值
//     4> 属性的持有方式 reatin, copy, assign
//     */
//    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return arrayM.copy;
}
//上面的代码中，有两段 判断是否有关联对象，和 设置关联对象的代码。是为了不重复执行此方法。

@end
