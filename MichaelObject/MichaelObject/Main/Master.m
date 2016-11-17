//
//  Master.m
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/8.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//


#import "Master.h"
#import "LoginController.h"

#import "HomeController.h"
#import "TestViewController.h"



@interface Master ()<UITabBarControllerDelegate
,UITabBarDelegate>
@property (assign, nonatomic) NSInteger barSelectedIndex;
@end

@implementation Master

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initView];
  [self createTabBar];
}

-(void)dealloc{
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
  // Dispose of any resources that can be recreated.
}

-(void)initView{
  
}


#pragma mark 私有方法
- (void)createTabBar {
  HomeController *homeVC =
      [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
  UINavigationController *homeNC =
      [[UINavigationController alloc] initWithRootViewController:homeVC];

//  homeNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_sy_sel"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  homeNC.tabBarItem.image = [[UIImage imageNamed:@"tab_sy_nor"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  homeNC.title = @"首页";

  TestViewController *drawVC =
      [[TestViewController alloc] init];
  UINavigationController *drawNC =
      [[UINavigationController alloc] initWithRootViewController:drawVC];
//  categoryNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_jg_sel"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  categoryNC.tabBarItem.image = [[UIImage imageNamed:@"tab_jg_nor"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  drawNC.title = @"签名";
//
//  RecordViewController *cartVC =
//      [[RecordViewController alloc] initWithNibName:@"RecordViewController"
//                                           bundle:nil];
//  UINavigationController *cartNC =
//      [[UINavigationController alloc] initWithRootViewController:cartVC];
//  cartNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_ba_sel"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  cartNC.tabBarItem.image = [[UIImage imageNamed:@"tab_ba_nor"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  cartNC.title = @"备案";
//
//  PersonalViewController *personalVC =
//      [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];
//  UINavigationController *personalNC =
//      [[UINavigationController alloc] initWithRootViewController:personalVC];
//  personalNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_wd_sel"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  personalNC.tabBarItem.image = [[UIImage imageNamed:@"tab_wd_nor"]
//      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  personalNC.title = @"我的";

    // 默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:9];
    attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xA8A6AE);
    
    // 选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:9];
    attrSelected[NSForegroundColorAttributeName] = UIColorFromRGB(0x0BB789);
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    //调整文字位置
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];

    
  [self.tabBar setTintColor:[UIColor colorWithRed:0.1383 green:0.1383 blue:0.1383 alpha:1.0]];
  UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
  bgView.backgroundColor = [UIColor whiteColor];
  [self.tabBar insertSubview:bgView atIndex:0];
  self.delegate = self;
  self.viewControllers = @[ homeNC, drawNC/*, categoryNC, cartNC, personalNC */];
  
}

-(void)selectMineTableBar{
    self.selectedIndex = 3;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
      if (self.selectedIndex != self.barSelectedIndex) {
        switch (self.selectedIndex) {
          case 0:
            [self notification];
            break;
          case 1:
            [self notification];
            break;
          case 3:

            break;
          case 4:

            break;
          default:
            break;
        }
      }
    }
  self.barSelectedIndex = self.selectedIndex;
}

- (void)notification
{
  NSNotification *notification =[NSNotification notificationWithName:@"workingNotifiCenter" object:nil userInfo:nil];
  [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if ([viewController.title isEqualToString:@"我的"] && ![AccountModel currentAccount]) {
//        
////        return NO;
//    }
//    if ([viewController.title isEqualToString:@"备案"]) {
//        if ([[AccountModel currentAccount].type integerValue] == 2) {
//            [UIAlertView showWithTitle:@"温馨提示" message:@"藏家身份不能备案" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//            return NO;
//        }
//        if (![AccountModel currentAccount]) {
//            [UIAlertView showWithTitle:@"温馨提示" message:@"游客不能备案," cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//            return NO;
//        }
        
        
//    }
    
  return YES;
}

-(void)goLogin{

}

@end
