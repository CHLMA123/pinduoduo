//
//  BaseTabBarController.m
//  pinduoduo
//
//  Created by MCL on 16/6/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "HotListViewController.h"
#import "SuperBrandViewController.h"
#import "SearchViewController.h"
#import "PersonalViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupChildControllers{
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabBarTitleName:@"首页" tabBarImageName:@"home" rootViewControllerClass:[HomeViewController class] rootViewControllerTitle:@"拼多多商城"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabBarTitleName:@"热榜" tabBarImageName:@"hotlist" rootViewControllerClass:[HotListViewController class] rootViewControllerTitle:@"排行榜"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabBarTitleName:@"海淘" tabBarImageName:@"SuperBrand" rootViewControllerClass:[SuperBrandViewController class] rootViewControllerTitle:@"海淘专区"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabBarTitleName:@"搜索" tabBarImageName:@"search" rootViewControllerClass:[SearchViewController class] rootViewControllerTitle:@"拼多多商城"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabBarTitleName:@"个人中心" tabBarImageName:@"person" rootViewControllerClass:[PersonalViewController class] rootViewControllerTitle:@"个人中心"];
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarTitleName:(NSString *)tabName tabBarImageName:(NSString *)imageName rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    UINavigationController *Nav = [[class alloc] initWithRootViewController:rootVC];
    Nav.tabBarItem.title = tabName;
    UIImage *img = [UIImage imageNamed:imageName];
    UIImage *selimg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    Nav.tabBarItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Nav.tabBarItem.selectedImage = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:Nav];
    
}

- (BOOL)isTabBarHidden{
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    return tabBarFrame.origin.y >= viewFrame.size.height;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    BOOL isHidden = self.tabBarHidden;
    if (hidden == isHidden) {
        return;
    }
    
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        NSLog(@"could not get the container view!");
        return;
    }
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
    }
    self.tabBar.frame = tabBarFrame;
    transitionView.frame = containerFrame;
    if (animated) {
        [UIView commitAnimations];
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
