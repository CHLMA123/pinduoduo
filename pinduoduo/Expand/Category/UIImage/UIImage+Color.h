//
//  UIImage+Color.h
//  Foscam
//
//  Created by song.wang on 14-7-2.
//  Copyright (c) 2014年 sunny_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  根据颜色生成指定大小的图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 *  根据颜色生成带有圆角的指定大小的图片
 *
 *  @param color  图片颜色
 *  @param size   图片大小
 *  @param corner 圆角位置
 *  @param size   圆角大小
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size byRoundingCorner:(UIRectCorner)corner cornerRadii:(CGSize)size;

@end
