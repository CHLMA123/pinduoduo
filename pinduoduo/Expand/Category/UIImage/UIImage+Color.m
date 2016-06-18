//
//  UIImage+Color.m
//  Foscam
//
//  Created by song.wang on 14-7-2.
//  Copyright (c) 2014年 sunny_zhang. All rights reserved.
//

#import "UIImage+Color.h"

#define kRectCornerNone 1000111

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    return [UIImage imageWithColor:color andSize:size byRoundingCorner:kRectCornerNone cornerRadii:CGSizeZero];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size byRoundingCorner:(UIRectCorner) corner cornerRadii:(CGSize)cornerSize
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (corner != kRectCornerNone) {
        [[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:cornerSize] addClip];
    }
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

@end
