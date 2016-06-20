//
//  XRCarouselView.m
//
//  Created by 肖睿 on 16/3/17.
//  Copyright © 2016年 肖睿. All rights reserved.
//

#import "XRCarouselView.h"
#import "GoodsSubjectModel.h"

typedef enum{
    DirecNone,
    DirecLeft,
    DirecRight
} Direction;

@interface XRCarouselView()<UIScrollViewDelegate>
//轮播的图片数组
@property (nonatomic, strong) NSMutableArray *images;
//下载的图片字典
@property (nonatomic, strong) NSMutableDictionary *imageDic;
//下载图片的操作
@property (nonatomic, strong) NSMutableDictionary *operationDic;
//滚动方向
@property (nonatomic, assign) Direction direction;
//提示信息
@property (nonatomic, strong) UILabel *promptLabel;
//显示的imageView
@property (nonatomic, strong) UIImageView *currImageView;
//辅助滚动的imageView
@property (nonatomic, strong) UIImageView *otherImageView;
//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;
//将要显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//任务队列
@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong)GoodsSubjectModel *imageModel;
@end

@implementation XRCarouselView
#pragma mark- 初始化方法
//创建用来缓存图片的文件夹
+ (void)initialize {
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XRCarousel"];
    BOOL isDir = NO;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:cache isDirectory:&isDir];
    if (!isExists || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

#pragma mark- frame相关
- (CGFloat)height {
    return self.scrollView.frame.size.height;
}

- (CGFloat)width {
    return self.scrollView.frame.size.width;
}

#pragma mark- 懒加载
- (NSMutableDictionary *)imageDic{
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}

- (NSMutableDictionary *)operationDic{
    if (!_operationDic) {
        _operationDic = [NSMutableDictionary dictionary];
    }
    return  _operationDic;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"没有图片哦，赶快去设置吧！";
        _promptLabel.font = [UIFont systemFontOfSize:20];
        _promptLabel.textColor = [UIColor blueColor];
        [_promptLabel sizeToFit];
        [self addSubview:_promptLabel];
    }
    return _promptLabel;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _currImageView = [[UIImageView alloc] init];
        _currImageView.userInteractionEnabled = YES;
        [_currImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        [_scrollView addSubview:_currImageView];
        _otherImageView = [[UIImageView alloc] init];
        [_scrollView addSubview:_otherImageView];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.font = [UIFont systemFontOfSize:13];
        _describeLabel.hidden = YES;
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark- 构造方法
- (instancetype)initWithImageArray:(NSArray *)imageArray {
    return [self initWithImageArray:imageArray imageClickBlock:nil];
}

+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray {
    return [self carouselViewWithImageArray:imageArray imageClickBlock:nil];
}

- (instancetype)initWithImageArray:(NSArray *)imageArray describeArray:(NSArray *)describeArray {
    if (self = [self initWithImageArray:imageArray]) {
        self.describeArray = describeArray;
    }
    return self;
}

+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray describeArray:(NSArray *)describeArray {
    return [[self alloc] initWithImageArray:imageArray describeArray:describeArray];
}

- (instancetype)initWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock {
    if (self = [super init]) {
        self.imageArray = imageArray;
        self.imageClickBlock = imageClickBlock;
    }
    return self;
}

+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock {
    return [[self alloc] initWithImageArray:imageArray imageClickBlock:imageClickBlock];
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"direction"];
}

#pragma mark- --------设置相关方法--------
#pragma mark 设置控件的frame
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.scrollView.frame = self.bounds;
    self.describeLabel.frame = CGRectMake(0, self.height - 20, self.width, 20);
    self.pageControl.center = CGPointMake(self.width * 0.5, self.height - 10);
    self.promptLabel.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    _scrollView.contentOffset = CGPointMake(self.width, 0);
    _currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
    [self setScrollViewContentSize];
}

#pragma mark 设置图片数组
- (void)setImageArray:(NSArray *)imageArray{
    if (!imageArray.count) return;
    self.promptLabel.hidden = YES;
    _imageArray = imageArray;
    _images = [NSMutableArray array];
    
    _imageModel = [[GoodsSubjectModel alloc] init];
    for (int i = 0; i < imageArray.count; i++) {
        //imageArray 的内容是GoodsSubjectModel
        _imageModel = imageArray[i];
        NSString *imageUrl = _imageModel.home_banner;
        
        if (imageUrl != nil) {
            [_images addObject:[UIImage imageNamed:@"placeholder"]];
            [self downloadImages:imageUrl withIndex:i];
        }
        
//        if ([imageArray[i] isKindOfClass:[UIImage class]]) {
//            [_images addObject:imageArray[i]];
//        } else if ([imageArray[i] isKindOfClass:[NSString class]]){
//            [_images addObject:[UIImage imageNamed:@"placeholder"]];
//            [self downloadImages:i];
//        }
    }
    self.currImageView.image = _images.firstObject;
    self.pageControl.numberOfPages = _images.count;
    [self setScrollViewContentSize];
}

- (void)setDescribeArray:(NSArray *)describeArray{
    _describeArray = describeArray;
    //如果描述的个数与图片个数不一致，则补空字符串
    if (describeArray && describeArray.count > 0) {
        if (describeArray.count < _images.count) {
            NSMutableArray *describes = [NSMutableArray arrayWithArray:describeArray];
            for (NSInteger i = describeArray.count; i < _images.count; i++) {
                [describes addObject:@""];
            }
            _describeArray = describes;
        }
        self.describeLabel.hidden = NO;
        _describeLabel.text = _describeArray.firstObject;
    }
}

#pragma mark 设置scrollView的contentSize
- (void)setScrollViewContentSize {
    if (_images.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.width * 3, 0);
        self.time = 5;
    } else {
        self.scrollView.contentSize = CGSizeZero;
    }
}


#pragma mark 设置pageControl的图片
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage {
    if (!pageImage || !currentImage) return;
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:pageImage forKey:@"_pageImage"];
}

#pragma mark 设置定时器时间
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self startTimer];
}

#pragma mark- --------定时器相关方法--------
- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_images.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
}

#pragma mark- -----------其它-----------
#pragma mark KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if(change[NSKeyValueChangeNewKey] == change[NSKeyValueChangeOldKey]) return;
    if ([change[NSKeyValueChangeNewKey] intValue] == DirecRight) {
        self.otherImageView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = _images.count - 1;
    } else if ([change[NSKeyValueChangeNewKey] intValue] == DirecLeft){
        self.otherImageView.frame = CGRectMake(CGRectGetMaxX(_currImageView.frame), 0, self.width, self.height);
        self.nextIndex = (self.currIndex + 1) % _images.count;
    }
    self.otherImageView.image = self.images[self.nextIndex];
}

#pragma mark 图片点击事件
- (void)imageClick {
    !self.imageClickBlock?:self.imageClickBlock(self.currIndex);
}

#pragma mark 下载网络图片
- (void)downloadImages:(NSString *)imageUrl withIndex:(int)index{

//- (void)downloadImages:(int)index {
//    NSString *key = _imageArray[index];
    
    NSString *key = imageUrl;
    //从内存缓存中取图片
    UIImage *image = [self.imageDic objectForKey:key];
    if (image) {
        _images[index] = image;
    }else{
        //从沙盒缓存中取图片
        NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XRCarousel"];
        NSString *path = [cache stringByAppendingPathComponent:[key lastPathComponent]];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            image = [UIImage imageWithData:data];
            _images[index] = image;
            [self.imageDic setObject:image forKey:key];
        }else{
            //下载图片
            NSBlockOperation *download = [self.operationDic objectForKey:key];
            if (!download) {
                //创建一个操作
                download = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *url = [NSURL URLWithString:key];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    if (data) {
                        UIImage *image = [UIImage imageWithData:data];
                        [self.imageDic setObject:image forKey:key];
                        self.images[index] = image;
                        //如果只有一张图片，需要在主线程主动去修改currImageView的值
                        if (_images.count == 1) [_currImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                        [data writeToFile:path atomically:YES];
                        [self.operationDic removeObjectForKey:key];
                    }
                }];
                [self.queue addOperation:download];
                [self.operationDic setObject:download forKey:key];
            }
        }
    }
}

#pragma mark 清除沙盒中的图片缓存
- (void)clearDiskCache {
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XRCarousel"];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cache error:NULL];
    for (NSString *fileName in contents) {
        [[NSFileManager defaultManager] removeItemAtPath:[cache stringByAppendingPathComponent:fileName] error:nil];
    }
}

#pragma mark- --------UIScrollViewDelegate--------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.direction = scrollView.contentOffset.x > self.width? DirecLeft : DirecRight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)pauseScroll {
    self.direction = DirecNone;
    int index = self.scrollView.contentOffset.x / self.width;
    if (index == 1) return;
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
    self.currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
    self.describeLabel.text = self.describeArray[self.currIndex];
    self.currImageView.image = self.otherImageView.image;
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
}

@end
