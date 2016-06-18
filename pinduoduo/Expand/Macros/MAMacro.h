//
//  MAMacro.h
//  图层蒙版
//
//  Created by MCL on 16/6/13.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef MAMacro_h
#define MAMacro_h

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7orLater IOS_VERSION>=7.0

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//透明背景色
#define CLEARCOLOR [UIColor clearColor]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 当前工程所用的到背景颜色
#define MBackgroundColor RGBCOLOR(240, 240, 240)


#define FSLocalizedString(key) (([CurrentLanguage rangeOfString:@"zh-Hans"].length || [CurrentLanguage rangeOfString:@"de"].length || [CurrentLanguage rangeOfString:@"fr"].length || [CurrentLanguage rangeOfString:@"es"].length)?([[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]))

// Size
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIs_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhone_6 (kIs_iPhone && SCREEN_HEIGHT == 667.0)
#define kIs_iPhone_6P (kIs_iPhone && SCREEN_HEIGHT == 736.0)

// block
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
/*
    // 宏定义之前的用法
    if (completionBlock)   {
    completionBlock(arg1, arg2);
    }
    // 宏定义之后的用法
    BLOCK_EXEC(completionBlock, arg1, arg2);
 */
// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

//  MRC和ARC混编设置方式
/*
    在XCode中targets的build phases选项下Compile Sources下选择 不需要arc编译的文件
    双击输入 -fno-objc-arc 即可

    MRC工程中也可以使用ARC的类，方法如下：
    在XCode中targets的build phases选项下Compile Sources下选择要使用arc编译的文件
    双击输入 -fobjc-arc 即可
 */

#endif /* MAMacro_h */








