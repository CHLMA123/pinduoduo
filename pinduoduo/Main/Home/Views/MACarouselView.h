//
//  MACarouselView.h
//  pinduoduo
//
//  Created by MCL on 16/6/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MACarouselView;
@protocol MACarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 *
 *  @param scrollView 一般传self
 *  @param info       每张图片对应的model，由控制器使用imageModelInfoArray属性传递过来，再由该方法传递回调用者
 */
-(void)MACarouselView:(MACarouselView *)scrollView tapImageViewInfo:(id)info;

@end

@interface MACarouselView : UIView

/**
 *  图片的信息，每张图片对应一个model，需要控制器传递过来
 */
@property (strong, nonatomic) NSMutableArray *imageModelInfoArray;
/**
 *  需要显示的图片，需要控制器传递过来
 */
@property (strong, nonatomic) NSArray *imageArray;
/**
 *  是否竖屏显示scrollview，默认是no
 */
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@property (weak,   nonatomic, readonly) UIPageControl *pageControl;
@property (assign, nonatomic) NSInteger ImageViewCount;
@property (weak,   nonatomic) id<MACarouselViewDelegate>delegate;

@end




