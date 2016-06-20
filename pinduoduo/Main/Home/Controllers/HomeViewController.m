//
//  HomeViewController.m
//  pinduoduo
//
//  Created by MCL on 16/6/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HomeViewController.h"

//#import "ViewController.h"
//@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
//
//@property (nonatomic, strong)UIScrollView *homeScrollView;
//@property (nonatomic, strong)UITableView *homeTableView;

#import "NetworkHelper.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIScrollView *homeScrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)UITableView *mainTableView;


@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    LOG_METHOD;
    [super viewWillAppear:animated];
    [self commitInitData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    LOG_METHOD;
    // Do any additional setup after loading the view.
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAction)];
//    [self.view addGestureRecognizer:singleTap];
    [self setupView];
}

//- (void)pushAction{
//    ViewController *vc = [[ViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

}

- (void)didReceiveMemoryWarning {
    LOG_METHOD;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{

    self.homeScrollView = [[UIScrollView alloc] init];
    self.homeScrollView.backgroundColor = [UIColor lightGrayColor];
    self.homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    self.homeScrollView.pagingEnabled = YES;
    self.homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *6, 220);
    self.homeScrollView.delegate = self;
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake((SCREEN_WIDTH - 150)*0.5, 195, 150, 15);
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = 6;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.homeScrollView];
    [headerView addSubview:self.pageControl];
    self.mainTableView = [[UITableView alloc] init];
    
    self.mainTableView.tableHeaderView = headerView;
    
    
}

- (void)viewDidLayoutSubviews{

}



#pragma mark - 获取网络数据
- (void)commitInitData{
    [self getSubjectData];
    [self getGoodListData];
}

- (void)getSubjectData{
    NSString *urlSubject = @"http://apiv2.yangkeduo.com/subjects";
    [[NetworkHelper sharedManager] getWithURL:urlSubject WithParmeters:nil compeletionWithBlock:^(NSDictionary *dic) {
        
//        NSLog(@"---getSubjectData--- dic = %@",dic);
    }];
}
- (void)getGoodListData{
    NSString *urlGoods = @"http://apiv2.yangkeduo.com/v2/goods?";
    NSDictionary *dic = @{@"size":@"50", @"page":@"1"};
    [[NetworkHelper sharedManager] getWithURL:urlGoods WithParmeters:dic compeletionWithBlock:^(NSDictionary *dic) {
        
//        NSLog(@"---getGoodListData--- dic = %@",dic);
    }];
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
