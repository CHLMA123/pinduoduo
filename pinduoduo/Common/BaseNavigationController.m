//
//  BaseNavigationController.m
//  图层蒙版
//
//  Created by MCL on 16/6/16.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppDelegate.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *attriDic = @{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.navigationBar setTitleTextAttributes:attriDic];
    self.navigationBar.barTintColor = [UIColor redColor];
//    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor] andSize:CGSizeMake(SCREEN_WIDTH, 65)] forBarMetrics:UIBarMetricsDefault];//作用同上句
//    [self setStatusColor];
}

//设置状态栏背景为任意的颜色
- (void)setStatusColor
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:statusBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        
        [self createBackBarItemWithViewController:viewController];//BackBarItem
        [self createrightBarItemWithViewController:viewController];//rightBarItem
    }
    [self setTabBarState];
//    if (self.childViewControllers.count > 0) {
//        
//        /* 自动显示和隐藏tabbar */
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//    }

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self setTabBarState];
    return vc;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *vcs = [super popToViewController:viewController animated:animated];
    [self setTabBarState];
    return vcs;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *vcs = [super popToRootViewControllerAnimated:animated];
    [self setTabBarState];
    return vcs;
}

- (void)createrightBarItemWithViewController:(UIViewController *)viewController{
    
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(SCREEN_WIDTH - 42, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"share_button"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backToParentView) forControlEvents:UIControlEventTouchUpInside];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *rBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.rightBarButtonItem = rBarButtonItem;

}

- (void)createBackBarItemWithViewController:(UIViewController *)viewController{
//    self.navigationBar.tintColor = [UIColor blackColor];//系统返回的箭头颜色定制
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backToParentView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.leftBarButtonItem = lBarButtonItem;
    
}

- (void)backToParentView{
    
    if ([self presentationController] && self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (void)setTabBarState{
    
    [[AppDelegate appDelegate].rootViewController setTabBarHidden:self.viewControllers.count > 1 animated:NO];
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
