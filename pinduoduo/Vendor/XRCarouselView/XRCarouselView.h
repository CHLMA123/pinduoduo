//
//  XRCarouselView.h
//
//  Created by 肖睿 on 16/3/17.
//  Copyright © 2016年 肖睿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger index);

@interface XRCarouselView : UIView
/*
 这里没有提供修改占位图片的接口，如果需要修改，可直接到.m文件中
 修改占位图片名称为你想要显示图片的名称，或者将你想要显示图片的
 名称修改为placeholder，因为太简单，没什么实际意义，所以就不
 提供接口了
 */


#pragma mark 属性
//分页控件，默认位置在底部中间
@property (nonatomic, strong) UIPageControl *pageControl;
//图片描述控件，默认在底部，黑色透明背景，13号白色字体
@property (nonatomic, strong) UILabel *describeLabel;
//轮播的图片数组，可以是图片，也可以是网络路径
@property (nonatomic, strong) NSArray *imageArray;
//图片描述的字符串数组，应与图片顺序对应
@property (nonatomic, strong) NSArray *describeArray;
//每一页停留时间，默认为5s，设置该属性会重新开启定时器
@property (nonatomic, assign) NSTimeInterval time;
//点击图片后要执行的操作，会返回图片在数组中的索引
@property (nonatomic, copy) ClickBlock imageClickBlock;


#pragma mark 构造方法
- (instancetype)initWithImageArray:(NSArray *)imageArray;
+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray;
- (instancetype)initWithImageArray:(NSArray *)imageArray describeArray:(NSArray *)describeArray;
+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray describeArray:(NSArray *)describeArray;;
- (instancetype)initWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock;
+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock;


#pragma mark 方法
//开启定时器（默认已开启，调用该方法会重新开启）
- (void)startTimer;
//停止定时器（停止定时器后，如果手动滚动图片，定时器会重新开启）
- (void)stopTimer;
//设置分页控件的图片,两个图片都不能为空，否则设置无效，不设置则为系统默认
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage;
//清除沙盒中的图片缓存
- (void)clearDiskCache;

@end
