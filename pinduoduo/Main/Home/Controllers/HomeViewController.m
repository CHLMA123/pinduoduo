//
//  HomeViewController.m
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkHelper.h"
#import "XRCarouselView.h"
#import "GoodsSubjectModel.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIScrollView *homeScrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *subjectModelMArr;
@property (nonatomic, strong)NSTimer *timer;

//@property (nonatomic, strong)UIImageView *scrollView1;
//@property (nonatomic, strong)UIImageView *scrollView2;
//@property (nonatomic, strong)UIImageView *scrollView3;
//@property (nonatomic, strong)UIImageView *scrollView4;
//@property (nonatomic, strong)UIImageView *scrollView5;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commitInitData];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    
    self.homeScrollView = [[UIScrollView alloc] init];
    self.homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    self.homeScrollView.backgroundColor = [UIColor lightGrayColor];
    self.homeScrollView.pagingEnabled = YES;
    self.homeScrollView.showsHorizontalScrollIndicator = NO;
    self.homeScrollView.showsVerticalScrollIndicator = NO;
    self.homeScrollView.delegate = self;
    [self.homeScrollView setBounces:NO];
    [_homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(0, 195, 150, 15);
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.center = CGPointMake(self.homeScrollView.center.x, 195);

    self.mainTableView = [[UITableView alloc] init];
    _mainTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 220);
    [self.view addSubview:self.mainTableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.homeScrollView];
    [headerView addSubview:self.pageControl];
    self.mainTableView.tableHeaderView = headerView;
    
}

- (void)viewDidLayoutSubviews{

}



#pragma mark - 获取网络数据
- (void)commitInitData{
    //网络图片
    [self getSubjectData];
    [self getGoodListData];
}

- (void)getSubjectData{
    NSString *urlSubject = @"http://apiv2.yangkeduo.com/subjects";
    [[NetworkHelper sharedManager] getWithURL:urlSubject WithParmeters:nil compeletionWithBlock:^(id obj) {
        
        NSLog(@"---getSubjectData--- dic = %@",obj);
        NSArray *dataArr = obj;
        _subjectModelMArr = [NSMutableArray array];
        for (int i = 0; i < dataArr.count; i ++) {
            NSDictionary *dic = dataArr[i];
            GoodsSubjectModel *subjectModel = [[GoodsSubjectModel alloc] init];
            [subjectModel setValuesForKeysWithDictionary:dic];
            [_subjectModelMArr addObject:subjectModel];
        }
        self.pageControl.numberOfPages = self.subjectModelMArr.count;
        self.homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *(self.subjectModelMArr.count +2), 220);
        UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake((_subjectModelMArr.count+1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, 220)];
        [_homeScrollView addSubview:firstImage];
        [_homeScrollView addSubview:lastImage];
        
        for (int i = 0; i < self.subjectModelMArr.count; i++) {
            GoodsSubjectModel * model = [[GoodsSubjectModel alloc] init];
            model = (GoodsSubjectModel *)self.subjectModelMArr[i];
            
            NSString *imageUrl = model.home_banner;
            if (i == 0) {
                [lastImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            if (i == self.subjectModelMArr.count -1) {
                [firstImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake((i+1) *SCREEN_WIDTH, 0, SCREEN_WIDTH, 220);
            imageView.tag = 100 + i;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
            [_homeScrollView addSubview:imageView];
            [self startTimer];
        }
        
    }];
}

- (void)getGoodListData{
    NSString *urlGoods = @"http://apiv2.yangkeduo.com/v2/goods?";
    NSDictionary *dic = @{@"size":@"50", @"page":@"1"};
    [[NetworkHelper sharedManager] getWithURL:urlGoods WithParmeters:dic compeletionWithBlock:^(id obj) {
        
//        NSLog(@"---getGoodListData--- dic = %@",dic);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
//    offsetX = offsetX + (SCREEN_WIDTH * 0.5);
    int page = offsetX / SCREEN_WIDTH;
//    self.pageControl.currentPage = page;
    if (page == 6) {
        
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat location = scrollView.contentOffset.x;
    if (location/SCREEN_WIDTH == 6) {
        NSLog(@"5");
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    else if (location/SCREEN_WIDTH == 0) {
        
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*5, 0) animated:NO];
        _pageControl.currentPage = 4;
    }
    else
    {
        _pageControl.currentPage  = location/SCREEN_WIDTH -1;
    }
    
    
}
#pragma mark - timer
- (void)startTimer{
    //只有一张图片
    if (self.subjectModelMArr.count == 1) {
        return;
    }
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeNextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeNextPage{
    
    CGFloat x = self.homeScrollView.contentOffset.x;
    int index = x / SCREEN_WIDTH;
    if (index < 7) {
//
//        if (index == 6 ) {
//            _pageControl.currentPage = 0;
//            [self.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
//        }
        if (index == 0) {

            [self.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*6, 0) animated:NO];
            _pageControl.currentPage = 4;
        }
        
        if (index!=0 && index !=6) {
            if (index == 5) {
                
                _pageControl.currentPage = 0;
                [self.homeScrollView setContentOffset:CGPointMake(0, 0) animated:NO];

            }else{
                _pageControl.currentPage = index;
                [self.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (index+1), 0) animated:YES];

            }
            
            }
    }


}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"main";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
