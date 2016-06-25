//
//  MACarouselView.m
//  pinduoduo
//
//  Created by MCL on 16/6/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MACarouselView.h" //没有使用 参考别人的代码

static int const ImageViewCount = 3;

@interface MACarouselView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property(assign,nonatomic)BOOL isFirstLoadImage;

@end

@implementation MACarouselView

#pragma mark- 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 图片控件
        for (int i = 0; i<ImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
        }
        
        // 页码视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addTap];
    
    self.scrollView.frame = self.bounds;
    if (self.isScrollDirectionPortrait) {//竖向滚动
        self.scrollView.contentSize = CGSizeMake(0, ImageViewCount * self.bounds.size.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
    }
    
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.isScrollDirectionPortrait) {//竖向滚动时imageview的frame
            imageView.frame = CGRectMake(0, i * self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        } else {//横向滚动时imageview的frame
            imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
    
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

#pragma mark - 添加点击手势
- (void)addTap
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCallback)];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
}

- (void)tapCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MACarouselView:tapImageViewInfo:)])
    {
        [self.delegate MACarouselView:self tapImageViewInfo:self.imageModelInfoArray[self.pageControl.currentPage]];
    }
}

#pragma mark - <UIScrollViewDelegate>
/*
 该方法的作用是判断当用户拖拽图片时，两张图片同时显示在屏幕上，如果用户此时松开手，那么应该完全显示哪张图片。此时我们需要判断哪张图片占据的屏幕比例较多，就显示该张图片。(PS : 移动scrollview的时候，不会改变image view的frame，只会不断改变scrollview的bounds，造成scrollview上面的子控件image view的位置也跟着不断变化，从而产生了image view在不断移动的感觉。)
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 当两张图片同时显示在屏幕中，找出占屏幕比例超过一半的那张图片
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    
    self.pageControl.currentPage = page;
}

//用手开始拖拽的时候，就停止定时器，不然用户拖拽的时候，也会出现换页的情况
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
//用户停止拖拽的时候，就启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}


//手指拖动scroll停止的时候，显示下一张图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self displayImage];
}

//定时器滚动scrollview停止的时候，显示下一张图片
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self displayImage];
}

#pragma mark - 显示图片处理
- (void)displayImage
{
    // 设置图片，三张imageview显示无限张图片
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        /**
         *  滚到第一张，并且是程序刚启动是第一次加载图片，index才减一。
         加上这个判断条件，是为了防止当程序第一次加载图片时，此时第一张图片的i=0，那么此时index--导致index<0，进入下面index<0的判断条件，让第一个imageview显示的是最后一张图片
         */
        if (i == 0 && self.isFirstLoadImage) {
            index--;
        }else if (i == 2) {//滚到最后一张图片，index加1
            index++;
        }
        
        if (index < 0) {//如果滚到第一张还继续向前滚，那么就显示最后一张
            index = self.pageControl.numberOfPages-1 ;
        }else if (index >= self.pageControl.numberOfPages) {//滚动到最后一张的时候，由于index加了一，导致index大于总的图片个数，此时把index重置为0，所以此时滚动到最后再继续向后滚动就显示第一张图片了
            index = 0;
        }
        
        imageView.tag = index;
        imageView.image = self.imageArray[index];
    }
    
    self.isFirstLoadImage =YES;
    
    // 偏移一个scrollview的高度或者宽度，让scrollview显示中间的imageview
//    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
//    } else {
//        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    }
    
}

- (void)displayNextImage
{
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}

#pragma mark - 定时器处理
- (void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(displayNextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer
{
    [self.timer invalidate];
    //需要手动设置timer为nil，因为定时器被系统强引用了，必须手动释放
    self.timer = nil;
}


#pragma mark - setter方法
- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    // 设置页码
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    
    // 设置内容
    [self displayImage];
    
    // 开始定时器
    [self startTimer];
}




@end

//1 http://ios.jobbole.com/84711/
/*
 https://github.com/codingZero/XRCarouselView
 最底层是一个UIView，上面有一个UIScrollView以及UIPageControl，scrollView上有两个UIImageView，imageView宽高 = scrollview宽高 = view宽高;
 假设轮播控件的宽度为x高度为y，我们设置scrollview的contentSize.width为3x，并让scrollview的水平偏移量为x，既显示最中间内容。
 */

//2 http://ios.jobbole.com/85673/
/*
 https://github.com/XiMuYouZi/InfiniteRoll
需求

三个imageview控件实现多张image的无限滚动
点击图片，可以拿到图片的信息给调用者使用
*/
