//
//  HomeController.m
//  MichaelObject
//
//  Created by 卢达洋 on 2016/11/15.
//  Copyright © 2016年 卢达洋. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBarItems{
  self.title = @"首页";
}

-(void)initView{

}
- (IBAction)goLogin:(UIButton *)sender {
  UIAlertView *aler = [UIAlertView showWithTitle:@"温馨提示"
                                       message:@"您尚未登录，前往登录页面"
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@[ @"登录" ]
                                      tapBlock:^(UIAlertView *_Nonnull alertView,
                                                 NSInteger buttonIndex) {
                                    
                                        if (buttonIndex == 1) {
                                          LoginController *vc = [[LoginController alloc]initWithNibName:@"LoginController" bundle:nil];
                                          UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
                                          nc.navigationBarHidden = YES;
                                          [self presentViewController:nc animated:YES completion:nil];
                                        }
                                      }];
                       
                         [aler show];
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
