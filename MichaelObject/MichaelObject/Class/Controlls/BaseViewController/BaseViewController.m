//
//  BaseViewController.m
//  iOSLibraryDemo
//
//  Created by 卢达洋 on 16/2/26.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initBaseView];
  [self hideNavigationBlackLine];
  [self initData];
  [self initView];
  [self initNavigationBarItems];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - 设置BaseView样式
-(void)initBaseView{
  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
  [self.navigationController.navigationBar setTranslucent:NO];
  self.edgesForExtendedLayout = UIRectEdgeNone;
//  UIButton *backBtn = [[[Global sharedSingleton] getCommonCustomViews] objectForKey:@"back"];
//  [[Global sharedSingleton] setLeftBarButtonForNavigationController:self withButton:backBtn andAction:@selector(back)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
//    self.hidesBottomBarWhenPushed=YES;
  }
  return self;
}
#pragma mark - 初始化数据,由子类重写改方法
- (void)initData {
}

#pragma mark - 初始化View,由子类重写改方法
- (void)initView {
}

#pragma mark - 初始化navigationBar,由子类重写改方法
- (void)initNavigationBarItems {
}

#pragma mark - 返回
- (void)back {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 隐藏导航栏下的黑线
- (void)hideNavigationBlackLine {
  if ([self.navigationController.navigationBar
          respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
    NSArray *list = self.navigationController.navigationBar.subviews;
    for (id obj in list) {
      if ([obj isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)obj;
        NSArray *list2 = imageView.subviews;
        for (id obj2 in list2) {
          if ([obj2 isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView2 = (UIImageView *)obj2;
            imageView2.hidden = YES;
          }
        }
      }
    }
  }
}

@end
