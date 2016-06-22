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
#import "GoodsListDataModel.h"
#import "RecommendSubjectsModel.h"
#import "SuperBrandDataModel.h"
#import "MobileAppGroupsModel.h"
#import "GoodsListTableViewCell.h"
#import "GroupBuyView.h"
#import "MItemCollectionViewCell.h"
#import "CollectionItemModel.h"

static NSString *collectionID = @"MItem";

@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *homeScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *subjectModelMArr;// 轮播数据源
@property (nonatomic, strong) NSMutableArray *goodslistMArr;// goods_list
@property (nonatomic, strong) NSMutableArray *recommendsubjectsMArr;// home_recommend_subjects
@property (nonatomic, strong) NSMutableArray *superbrandMArr;// home_super_brand
@property (nonatomic, strong) NSMutableArray *mobileappgroupsMArr;// mobile_app_groups
@property (nonatomic, strong) GroupBuyView *groupBuyView;
@property (nonatomic, strong) UICollectionView *homeCollectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, strong) NSArray *itemArray;//collectionView 的数据源

////下载的图片字典
//@property (nonatomic, strong) NSMutableDictionary *imageDic;
////下载图片的操作
//@property (nonatomic, strong) NSMutableDictionary *operationDic;
////任务队列
//@property (nonatomic, strong) NSOperationQueue *queue;



@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self commitInitData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _imageDic = [NSMutableDictionary dictionary];
//    _operationDic = [NSMutableDictionary dictionary];
//    _queue = [[NSOperationQueue alloc] init];
    
    _subjectModelMArr = [NSMutableArray array];
    _goodslistMArr = [NSMutableArray array];
    _recommendsubjectsMArr = [NSMutableArray array];
    _superbrandMArr = [NSMutableArray array];
    _mobileappgroupsMArr = [NSMutableArray array];
    _itemArray = [NSArray array];
    
    //init UICollectionView的数据源 #import "CollectionItemModel.h"
    [self setupCollectionData];
    
    [self commitInitData];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    
    self.homeScrollView = [[UIScrollView alloc] init];
    _homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    _homeScrollView.backgroundColor = [UIColor lightGrayColor];
    _homeScrollView.pagingEnabled = YES;
    _homeScrollView.showsHorizontalScrollIndicator = NO;
    _homeScrollView.showsVerticalScrollIndicator = NO;
    _homeScrollView.delegate = self;
    _homeScrollView.tag = 2000;
    [_homeScrollView setBounces:NO];
    [_homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, 195, 150, 15);
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.center = CGPointMake(self.homeScrollView.center.x, 195);

    CGFloat collectionW = SCREEN_WIDTH;
    CGFloat collectionH = 110;
    self.itemCount = 10;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.itemSize = CGSizeMake(collectionH, collectionH);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.homeCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 230, collectionW, collectionH) collectionViewLayout:_flowLayout];
    _homeCollectionV.showsHorizontalScrollIndicator = YES;
    _homeCollectionV.showsVerticalScrollIndicator = NO;
    _homeCollectionV.delegate = self;
    _homeCollectionV.dataSource = self;
//    _homeCollectionV.pagingEnabled = YES;
    [_homeCollectionV setBounces:NO];
    [self.homeCollectionV registerClass:[MItemCollectionViewCell class] forCellWithReuseIdentifier:collectionID];
    
    self.groupBuyView = [[GroupBuyView alloc] init];
    _groupBuyView.frame = CGRectMake(0, 350, SCREEN_WIDTH, 80);
//    _groupBuyView.backgroundColor = [UIColor purpleColor];
    
    self.mainTableView = [[UITableView alloc] init];
    _mainTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 430)];
    headerView.backgroundColor = RGBACOLOR(240, 240, 240, 240);
    [headerView addSubview:self.homeScrollView];
    [headerView addSubview:self.pageControl];
    [headerView addSubview:self.homeCollectionV];
    [headerView addSubview:self.groupBuyView];
    self.mainTableView.tableHeaderView = headerView;
    
}

- (void)viewDidLayoutSubviews{

}

- (void)setupCollectionData{
    NSArray *descArr = @[@"秒杀",@"超值大牌",@"9块9特卖",@"抽奖",@"食品",@"服饰箱包",@"家居生活",@"母婴",@"美妆护肤",@"海淘"];
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (int i =0 ; i < 10; i ++) {
        CollectionItemModel *model = [[CollectionItemModel alloc] init];
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"findhome_%d",i]];
        model.imageDesc = descArr[i];
        [mArr addObject:model];
    }
    _itemArray = mArr;
}

#pragma mark - 获取网络数据
- (void)commitInitData{
    NSLog(@"当前设备网络状态: %@", [AppDelegate appDelegate].curNetworkStatus);
    //创建用来缓存图片的文件夹
    [self setupCacheFolder];
    //网络图片
    [self getSubjectData];
    [self getGoodListData];
}

- (void)setupCacheFolder{
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MACarousel"];
    BOOL isDir = NO;
    BOOL isExsit = [[NSFileManager defaultManager] fileExistsAtPath:cache isDirectory:&isDir];
    if (!isDir || !isExsit) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)getSubjectData{
    NSString *urlSubject = @"http://apiv2.yangkeduo.com/subjects";
    [[NetworkHelper sharedManager] getWithURL:urlSubject WithParmeters:nil compeletionWithBlock:^(id obj) {
        
        //NSLog(@"---getSubjectData--- obj = %@",obj);
        NSArray *dataArr = obj;
        // *1 获取数据源
        for (int i = 0; i < dataArr.count; i ++) {
            NSDictionary *dic = dataArr[i];
            GoodsSubjectModel *subjectModel = [[GoodsSubjectModel alloc] init];
            [subjectModel setValuesForKeysWithDictionary:dic];
            [_subjectModelMArr addObject:subjectModel];
        }
        [self showScrollView];
        
    }];
}

- (void)getGoodListData{
    NSString *urlGoods = @"http://apiv2.yangkeduo.com/v2/goods?";
    NSDictionary *dic = @{@"size":@"50", @"page":@"1"};
    [[NetworkHelper sharedManager] getWithURL:urlGoods WithParmeters:dic compeletionWithBlock:^(id obj) {
        
        NSLog(@"---getGoodListData--- obj = %@",obj);
        NSDictionary *dataDic = obj;
        NSArray *goods_list = [dataDic objectForKey:@"goods_list"];
        // 1 goods_list
        for (int i = 0; i < goods_list.count; i ++) {
            NSDictionary *dic = goods_list[i];
            GoodsListDataModel *model = [[GoodsListDataModel alloc] init];
            //[model setValuesForKeysWithDictionary:dic];
            model.goods_id = [dic objectForKey:@"goods_id"];
            model.goods_name = [dic objectForKey:@"goods_name"];
            model.image_url = [dic objectForKey:@"image_url"];
            model.is_app = [dic objectForKey:@"is_app"];
            NSDictionary *group = [dic objectForKey:@"group"];
            model.price = [group objectForKey:@"price"];
            model.customer_num = [group objectForKey:@"customer_num"];
            
            [_goodslistMArr addObject:model];
        }
        // 2 home_recommend_subjects
        NSArray *arrHome_recommend_subjects = [dataDic objectForKey:@"home_recommend_subjects"];
        RecommendSubjectsModel *recommendModel = [[RecommendSubjectsModel alloc] init];
        for (int i = 0; i < arrHome_recommend_subjects.count; i ++) {
            NSDictionary *dic = arrHome_recommend_subjects[i];
            // 2.1 recommendModel.goodSubjectModel
            GoodsSubjectModel *subjectModel = [[GoodsSubjectModel alloc] init];
            {
                subjectModel.subject_id = [dic objectForKey:@"subject_id"];
                subjectModel.subject = [dic objectForKey:@"subject"];
                subjectModel.second_name = [dic objectForKey:@"second_name"];
                subjectModel.desc = [dic objectForKey:@"desc"];
                subjectModel.home_banner = [dic objectForKey:@"home_banner"];
                subjectModel.home_banner_height = [dic objectForKey:@"home_banner_height"];
                subjectModel.home_banner_width = [dic objectForKey:@"home_banner_width"];
                subjectModel.type = [dic objectForKey:@"type"];
                subjectModel.position = [dic objectForKey:@"position"];
                subjectModel.share_image = [dic objectForKey:@"share_image"];
            }
            recommendModel.goodSubjectModel = subjectModel;
            //  2.2 recommendModel.goodlistArr
            NSMutableArray *goodsMArr = [[NSMutableArray alloc] init];
            NSArray *goods = [dic objectForKey:@"goods_list"];
            for (int i = 0; i < goods.count; i ++) {
                GoodsListDataModel *goodsModel = [[GoodsListDataModel alloc] init];
                NSDictionary *dic = goods[i];
                [goodsModel setValuesForKeysWithDictionary:dic];
                [goodsMArr addObject:goodsModel];
            }
            recommendModel.goodlistArr = goodsMArr;
        }
        [_recommendsubjectsMArr addObject:recommendModel];
        
        // 3 home_super_brand
        NSDictionary *arrhome_super_brand = [dataDic objectForKey:@"home_super_brand"];
        SuperBrandDataModel *superbrandModel = [[SuperBrandDataModel alloc] init];
        
            NSDictionary *dic = arrhome_super_brand;
            // 3.1 recommendModel.goodSubjectModel
            GoodsSubjectModel *subjectModel = [[GoodsSubjectModel alloc] init];
            {
                subjectModel.subject_id = [dic objectForKey:@"subject_id"];
                subjectModel.subject = [dic objectForKey:@"subject"];
                subjectModel.second_name = [dic objectForKey:@"second_name"];
                subjectModel.desc = [dic objectForKey:@"desc"];
                subjectModel.home_banner = [dic objectForKey:@"home_banner"];
                subjectModel.home_banner_height = [dic objectForKey:@"home_banner_height"];
                subjectModel.home_banner_width = [dic objectForKey:@"home_banner_width"];
                subjectModel.type = [dic objectForKey:@"type"];
                subjectModel.position = [dic objectForKey:@"position"];
                subjectModel.share_image = [dic objectForKey:@"share_image"];
                
                subjectModel.start_time = [dic objectForKey:@"start_time"];
                subjectModel.end_time = [dic objectForKey:@"end_time"];
            }
            superbrandModel.goodSubjectModel = subjectModel;
            //  3.2 SuperBrandDataModel.goodlistArr
            NSMutableArray *goodsMArr = [[NSMutableArray alloc] init];
            NSArray *goods = [dic objectForKey:@"goods_list"];
            for (int i = 0; i < goods.count; i ++) {
                GoodsListDataModel *goodsModel = [[GoodsListDataModel alloc] init];
                NSDictionary *dic = goods[i];
                [goodsModel setValuesForKeysWithDictionary:dic];
                [goodsMArr addObject:goodsModel];
            }
            superbrandModel.goodlistArr = goodsMArr;
        
        [_superbrandMArr addObject:recommendModel];
        
        
        // 4 mobile_app_groups
        NSArray *arrmobile_app_groups = [dataDic objectForKey:@"mobile_app_groups"];
        for (int i = 0 ; i <arrmobile_app_groups.count; i ++) {
            NSDictionary *dic = arrmobile_app_groups[i];
            MobileAppGroupsModel *groupModel = [[MobileAppGroupsModel alloc] init];
            [groupModel setValuesForKeysWithDictionary:dic];
            [_mobileappgroupsMArr addObject:groupModel];
        }
        
        BLOCK_EXEC(self.groupBuyView.block, _mobileappgroupsMArr[0]);
        
        [self.mainTableView reloadData];
        
    }];
}

#pragma mark - TableView数据处理

#pragma mark - ScrollView数据处理
- (void)showScrollView{// *2 处理并显示数据
    
    self.pageControl.numberOfPages = self.subjectModelMArr.count;
    self.homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *(self.subjectModelMArr.count +2), 220);
    //实现循环滚动
    //在前后各添加一个冗余的view
    //1.在最前面添加一个view,用来显示和最后一页相同的内容
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    //2.在最后一页的后面添加一个view,用来显示和第一页相同的内容
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake((_subjectModelMArr.count+1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, 220)];
    [_homeScrollView addSubview:firstImage];
    [_homeScrollView addSubview:lastImage];
    
    for (int i = 0; i < self.subjectModelMArr.count; i++) {
        GoodsSubjectModel * model = [[GoodsSubjectModel alloc] init];
        model = (GoodsSubjectModel *)self.subjectModelMArr[i];
        
        NSString *imageUrl = model.home_banner;
        if (i == 0) {
            [lastImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_load"]];
        }
        if (i == self.subjectModelMArr.count -1) {
            [firstImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_load"]];
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((i+1) *SCREEN_WIDTH, 0, SCREEN_WIDTH, 220);
        imageView.tag = 100 + i;
        
//        //从内存缓存中取图片
//        UIImage *image = [self.imageDic objectForKey:imageUrl];
//        if (image) {
//            imageView.image = image;
//        }else{
//            //从沙盒缓存中取图片
//            NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MACarousel"];
//            NSString *stringPath = [cache stringByAppendingPathComponent:[imageUrl lastPathComponent]];
//            NSData *data = [NSData dataWithContentsOfFile:stringPath];
//            if (data) {
//                imageView.image = [UIImage imageWithData:data];
//                [self.imageDic setObject:[UIImage imageWithData:data] forKey:imageUrl];
//            }else{
//               //下载图片
//                NSBlockOperation *operationDownload = [self.operationDic objectForKey:imageUrl];
//                if (!operationDownload) {
//                    operationDownload = [NSBlockOperation blockOperationWithBlock:^{
//                        NSURL *url = [NSURL URLWithString:imageUrl];
//                        NSData *data = [NSData dataWithContentsOfURL:url];
//                        if (data) {
//                            imageView.image = [UIImage imageWithData:data];
//                            [self.imageDic setObject:[UIImage imageWithData:data] forKey:imageUrl];
//                            [data writeToFile:stringPath atomically:YES];
//                            [self.operationDic removeObjectForKey:imageUrl];
//                        }
//                    }];
//                    [self.queue addOperation:operationDownload];
//                    [self.operationDic setObject:operationDownload forKey:imageUrl];
//                }
//                
//            }
//            
//        
//        }

        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [_homeScrollView addSubview:imageView];
        [self startTimer];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //LOG_METHOD;
    if (scrollView.tag == 2000) {
        CGFloat offsetX = scrollView.contentOffset.x;
        int page = offsetX / SCREEN_WIDTH;
        if (page == 6) {
            //解决最后一张有延时的问题
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
            self.pageControl.currentPage = 0;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //LOG_METHOD;
    if (scrollView.tag == 2000) {
        [self stopTimer];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //LOG_METHOD;
    if (scrollView.tag == 2000) {
        [self startTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //LOG_METHOD;
    
    if (scrollView.tag == 2000) {
        CGPoint currentLocation = scrollView.contentOffset;
        CGFloat offsetx = currentLocation.x + SCREEN_WIDTH;
        if (offsetx/SCREEN_WIDTH == 6) {//判断是否已经翻到最后
            //将当前位置设置为原来的第一张图片
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
            _pageControl.currentPage = 0;
        }
        else if (currentLocation.x/SCREEN_WIDTH == 0) {//判断是否已经翻到最后
            //将当前位置设置为原来的最后一张图片
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*5, 0) animated:NO];
            _pageControl.currentPage = 4;
        }
        else
        {
            _pageControl.currentPage  = currentLocation.x/SCREEN_WIDTH -1;
        }
   
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeNextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeNextPage{
    //LOG_METHOD;
    CGPoint currentLocation = _homeScrollView.contentOffset;
    CGPoint offset = CGPointMake(currentLocation.x + SCREEN_WIDTH, 0);
    [self.homeScrollView setContentOffset:offset animated:YES];
    
    if (offset.x/SCREEN_WIDTH == self.subjectModelMArr.count +1) {//判断是否已经翻到最后
        //将当前位置设置为原来的第一张图片
        _pageControl.currentPage = 0;
        //NSLog(@"%lu", self.subjectModelMArr.count +1);
    }
    else if (currentLocation.x/SCREEN_WIDTH == 0) {//判断是否已经翻到最前
        //将当前位置设置为原来的最后一张图片
        _pageControl.currentPage = self.subjectModelMArr.count -1;
    }
    else
    {
        _pageControl.currentPage  = currentLocation.x/SCREEN_WIDTH;
//        NSLog(@"%ld", (long)_pageControl.currentPage);
    }

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 360;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodslistMArr.count;
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"main";
    GoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GoodsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger index = indexPath.row;
    [cell fillCellWithModel:self.goodslistMArr[index]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGBCOLOR(240, 240, 240);
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    CollectionItemModel *model = _itemArray[indexPath.item];
    cell.imageView.image = model.image;
    cell.imageLbl.text = model.imageDesc;
//    if (indexPath.item %2 == 0) {
//        cell.backgroundColor = [UIColor redColor];
//    }else
//    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的item---%zd",indexPath.item);
}


#pragma mark 清除沙盒中的图片缓存
- (void)clearDiskCache {
    NSString *cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MACarousel"];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cache error:NULL];
    for (NSString *fileName in contents) {
        [[NSFileManager defaultManager] removeItemAtPath:[cache stringByAppendingPathComponent:fileName] error:nil];
    }
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
