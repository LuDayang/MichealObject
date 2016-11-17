//
//  RegisterViewController.m
//  GuoJian
//
//  Created by 卢达洋 on 16/9/20.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerTop;
@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *goLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCaptchaBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end

@implementation RegisterViewController{
    __block int timeout; //倒计时时间
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [_phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_pswTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_captchaTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
  [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
  
}

-(void)viewWillLayoutSubviews{
  if (!_isRegister) {
    _agreementView.hidden = YES;
      _goLoginBtn.hidden = YES;
    _confirmBtn.titleLabel.text = @"确定";
    _registerTop.constant = 0;
  }
}

-(void)initView{
    [self.confirmBtn makeRoundedCorner:3];
    [self.getCaptchaBtn makeRoundedCorner:16];
    [_confirmBtn setBackgroundImage:[_confirmBtn buttonImageFromColor:RGBACOLOR(216, 221, 225, 1)] forState:UIControlStateDisabled];
    
    [_getCaptchaBtn setBackgroundImage:[_getCaptchaBtn buttonImageFromColor:RGBACOLOR(216, 221, 225, 1)] forState:UIControlStateDisabled];
    
    [_getCaptchaBtn setBackgroundImage:[_getCaptchaBtn buttonImageFromColor:RGBACOLOR(11, 183, 137, 1)] forState:UIControlStateNormal];
    
    [_getCaptchaBtn setTitleColor:RGBACOLOR(159, 166, 173, 1) forState:UIControlStateNormal];
    [_getCaptchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma buttonAction
- (IBAction)confirmClick:(UIButton *)sender {
    
    BOOL ispass = [self inputCheak];
    if (!ispass) {
        return;
    }
    
    [self.view endEditing:YES];
    if (_isRegister) { 
      BmobUser *bUser = [[BmobUser alloc] init];
      [bUser setUsername:_phoneTF.text];
      [bUser setPassword:_pswTF.text];
      [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
          [self.view makeToast:@"注册成功" duration:1 position:CSToastPositionCenter];
                      if (isSuccessful) {
                          [self performSelector:@selector(back) withObject:nil afterDelay:1];
                      }
        } else {
          NSLog(@"%@",error);
        }
      }];
    }else{
//        [UserInterface findPasswordWithMobileNum:_phoneTF.text Password:_pswTF.text VerifCode:_captchaTF.text  Completion:^(BOOL success, NSString *errorcode, NSString *msg) {
//             [self.view makeToast:msg duration:1 position:CSToastPositionCenter];
//            if (success) {
//                [self performSelector:@selector(back) withObject:nil afterDelay:1];
//            }
//        }Error:^(NSError *error) {
//            
//        }];
    }
}
- (IBAction)goLonginClick:(id)sender {
    [self back];
}

- (IBAction)agreeBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (_phoneTF.text.length == 11 && _pswTF.text.length >= 6 && _captchaTF.text.length == 6 && !_agreeBtn.isSelected) {
        _confirmBtn.enabled = YES;
    }else{
        _confirmBtn.enabled = NO;
    }
}

- (IBAction)getCaptchaClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![_phoneTF.text regexMatcheMobile]) {
        [self.view makeToast:@"请输入正确的手机号"
                    duration:1
                    position:CSToastPositionCenter];
        return ;
    }
    
//    [UserInterface SendVerCodeWithMobileNum:_phoneTF.text Type:_isRegister?nil:@"findpwd" Em:OPEN_TEST_DOMAIN ? @"1":@"0"  Completion:^(BOOL success, NSString *captcha, NSString *errorcode, NSString *msg) {
//        [self.view makeToast:msg duration:1 position:CSToastPositionCenter];
//        
//        
//        
//        if (success) {
//            _getCaptchaBtn.enabled = NO;
//            [self startTime];
//            [_captchaTF becomeFirstResponder];
//#if OPEN_TEST_DOMAIN
//             MYALERTBYTITLE(@"验证码", captcha, self)
//#else
//            
//#endif
//        }
//    }Error:^(NSError *error) {
//        
//    }];
}


- (IBAction)showContract:(UITapGestureRecognizer *)sender {
//    WebController *vc = [[WebController alloc] init];
//    vc.title = @"使用条款和个人隐私";
//    vc.url = CREATE_REAL_URL(kAPI_HOST, @"/wap/regisTerms.jsp");
//    [self.navigationController pushViewController:vc animated:YES];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    if (textField == _phoneTF) {
        return [TextFieldUtil limitTextEntryWith:11 textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }else if (textField == _pswTF){
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        return [TextFieldUtil limitTextEntryWith:16 textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }else{
        return [TextFieldUtil limitTextEntryWith:6 textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
}

#pragma mark 私有方法
-(void)textFieldChanged:(UITextField *)textField{
    
    if (_phoneTF.text.length == 11 && [_getCaptchaBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
        _getCaptchaBtn.enabled = YES;
    }else{
        _getCaptchaBtn.enabled = NO;
    }
    
    if (_phoneTF.text.length == 11 && _pswTF.text.length >= 6 && _captchaTF.text.length >= 1 && !_agreeBtn.isSelected) {
        _confirmBtn.enabled = YES;
    }else{
        _confirmBtn.enabled = NO;
    }
}

- (BOOL)inputCheak {
    if (![_phoneTF.text regexMatcheMobile]) {
        [self.view makeToast:@"请输入正确的手机号"
                    duration:1
                    position:CSToastPositionCenter];
        return NO;
    }
    if (![_pswTF.text regexMatchePassword]) {
        
        [self.view makeToast:@"请输入6~16个字母和数字组合密码"
                    duration:1
                    position:CSToastPositionCenter];
        return NO;
    }
  
    return YES;
}


-(void)back{
  [super back];
}

- (void)startTime {
    //    __block int timeout = 90; //倒计时时间
    timeout = 90;
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer =
    dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),
                              1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCaptchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _getCaptchaBtn.enabled = NO;
                _getCaptchaBtn.enabled = YES;
            });
        } else {
            int seconds = timeout % 91;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCaptchaBtn setTitle:[NSString stringWithFormat:@"%@S", strTime]
                                forState:UIControlStateDisabled];
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
