//
//  LoginController.m
//  GuoJian
//
//  Created by 卢达洋 on 16/9/20.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "LoginController.h"
#import "RegisterViewController.h"
//#import "UMSocialAccountManager.h"
//#import "UMSocialSnsPlatformManager.h"
//#import "UMSocialSnsService.h"

@interface LoginController ()<UITextFieldDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHeight;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *findPswBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationController.delegate = self;
#if OPEN_TEST_DOMAIN
//    _phoneTF.text = @"13557547400";
//    _pswTF.text = @"123456a";
    [self textFieldChanged:_phoneTF];
#endif
    _phoneTF.text = @"13557547400";
    _pswTF.text = @"123456a";
    [_phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_pswTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
  
  _btnHeight.constant = kScreenWidth * 42 / 375;
  
  [self.loginBtn makeRoundedCorner:3];
  [self.wxLoginBtn makeRoundedCorner:3];
  [self.registerBtn makeRoundedCorner:3];
    [self.backBtn makeRoundedCorner:3];
  

  self.pswTF.layer.borderColor = RGBACOLOR(216, 216, 216, 1).CGColor;
  self.pswTF.layer.borderWidth = 1.f;
  self.pswTF.layer.cornerRadius = 4.f;
  self.pswTF.leftViewMode = UITextFieldViewModeAlways;
//  self.pswTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
  
  self.phoneTF.layer.borderColor = RGBACOLOR(216, 216, 216, 1).CGColor;
  self.phoneTF.layer.borderWidth = 1.f;
  self.phoneTF.layer.cornerRadius = 4.f;
  self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
//  self.phoneTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
  
  
}

- (void)initView{
  
    [_loginBtn setBackgroundImage:[_loginBtn buttonImageFromColor:RGBACOLOR(216, 221, 225, 1)] forState:UIControlStateDisabled];
    self.phoneTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *phoneIconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dl_sj"]];
    phoneIconImg.frame = CGRectMake(12, 2.3f, 16, 16);
    phoneIconImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.phoneTF.leftView addSubview:phoneIconImg];

    self.pswTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.pswTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *passwordLockIconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dl_mm"]];
    passwordLockIconImg.frame = CGRectMake(12, 2.3f, 16, 16);
    passwordLockIconImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.pswTF.leftView addSubview:passwordLockIconImg];
}

- (IBAction)goRegisterVC:(UIButton *)sender {
    [self.view endEditing:YES];
  RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
  vc.title = @"忘记密码";
  if ([sender.titleLabel.text isEqualToString:@"注册账号"]) {
    vc.isRegister = YES;
    vc.title = @"注册";
  }
//   [self.navigationController setNavigationBarHidden:NO animated:NO];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITextFieldDelegate
-(void)textFieldChanged:(UITextField *)textField{
    if (_phoneTF.text.length == 11 && _pswTF.text.length >= 6) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    if (textField == _phoneTF) {
        return [TextFieldUtil limitTextEntryWith:11 textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }else{
        
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        return [TextFieldUtil limitTextEntryWith:16 textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
}

#pragma mark Privately Methods
- (BOOL)inputCheak {
    if (![_phoneTF.text regexMatcheMobile]) {        
        [self.view makeToast:@"请输入正确的手机号"
                    duration:1
                    position:CSToastPositionCenter];
        
        return NO;
    }if (![_pswTF.text regexMatchePassword]) {
        
//        [self.view makeToast:@"请输入6~16个字母和数字组合密码"
//                    duration:1
//                    position:CSToastPositionCenter];
//        
//        return NO;
    }
    return YES;
}
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tabBarController setSelectedIndex:3];
    }];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    if (![self inputCheak]) {
        return;
    }
    [self.view endEditing:YES];
  [BmobUser loginWithUsernameInBackground:_phoneTF.text password:_pswTF.text block:^(BmobUser *user, NSError *error) {
    if (user) {
      NSLog(@"user:%@",user);
      NSString *msg = [NSString stringWithFormat:@"%@登录成功",user.username];
      [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
    }
  }];
  
}

//微信登录
- (IBAction)wxLoginBtnClick:(id)sender {
    [self.view endEditing:YES];
//        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager
//                                            getSocialPlatformWithName:UMShareToWechatSession];
//        
//        snsPlatform.loginClickHandler(
//                                      self, [UMSocialControllerService defaultControllerService], YES,
//                                      ^(UMSocialResponseEntity *response) {
//                                          
//                                          if (response.responseCode == UMSResponseCodeSuccess) {
//                                              
//                                              UMSocialAccountEntity *snsAccount =
//                                              [[UMSocialAccountManager socialAccountDictionary]
//                                               valueForKey:UMShareToWechatSession];
//                                             [UserInterface quicklyLoginWithNickname:snsAccount.userName Headimg:snsAccount.iconURL Sex:@"0" Openid:snsAccount.usid Type:@"0" Completion:^(BOOL success, AccountModel *account, NSString *errorcode, NSString *msg) {
//                                                 NSLog(@"account%@",account);
//                                                 [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
//                                                 if (success) {
//                                                     [self performSelector:@selector(backBtnClick:) withObject:nil afterDelay:2];
//                                                 }
//                                             } Error:^(NSError *error) {
//                                                         [self.view makeToast:error.description duration:2 position:CSToastPositionCenter];
//                                             }];
//                                              NSLog(@"username is %@, uid is %@, token is %@ url is %@",
//                                                    snsAccount.userName, snsAccount.usid, snsAccount.accessToken,
//                                                    snsAccount.iconURL);
//                                          }
//                                      });
}
-(void)viewWillAppear:(BOOL)animated{
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
