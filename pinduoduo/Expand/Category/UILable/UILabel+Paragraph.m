//
//  UILabel+Paragraph.m
//  MAPayPalDemo
//
//  Created by MCL on 16/3/18.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "UILabel+Paragraph.h"

@implementation UILabel (Paragraph)

+ (UILabel *)makeLableWithText:(NSString *)textStr WithTextColor:(UIColor *)color{
    
    UILabel *lblModel = [[UILabel alloc] init];
    lblModel.textColor =color;
    lblModel.textAlignment = NSTextAlignmentCenter;
    lblModel.backgroundColor = [UIColor clearColor];
    lblModel.numberOfLines =0;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    [lblModel setAttributedText:attributedString];
    
    return lblModel;
}

@end
