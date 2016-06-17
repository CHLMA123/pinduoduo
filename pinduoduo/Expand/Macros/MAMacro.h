//
//  MAMacro.h
//  图层蒙版
//
//  Created by MCL on 16/6/13.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef MAMacro_h
#define MAMacro_h

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

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


//  MRC和ARC混编设置方式
/*
    在XCode中targets的build phases选项下Compile Sources下选择 不需要arc编译的文件
    双击输入 -fno-objc-arc 即可

    MRC工程中也可以使用ARC的类，方法如下：
    在XCode中targets的build phases选项下Compile Sources下选择要使用arc编译的文件
    双击输入 -fobjc-arc 即可
 */

#endif /* MAMacro_h */








