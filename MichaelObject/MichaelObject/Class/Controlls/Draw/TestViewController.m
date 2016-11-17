//
//  TestViewController.m
//  PopSign
//
//  Created by jun.wang on 14-7-1.
//  Copyright (c) 2014年 wj. All rights reserved.
//

#import "TestViewController.h"
#import "PopSignUtil.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SYSTEMFONT(x) [UIFont systemFontOfSize:(x)]

@interface TestViewController ()

@end

@implementation TestViewController{
    UIButton *addBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self createView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.title = @"签名";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)createView{
    //self
    self.view.backgroundColor = RGBCOLOR(110, 220, 220);

    //addBtn
    addBtn = [[UIButton alloc]init];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [RGBCOLOR(98, 169, 184)CGColor];
    [addBtn setTitle:@"点击签名" forState:UIControlStateNormal];
    addBtn.titleLabel.font = SYSTEMFONT(18);
    //    [addBtn setBackgroundImage:[UIImage imageNamed:@"pic_add.png"] forState:UIControlStateNormal];
    //    [addBtn setBackgroundImage:[UIImage imageNamed:@"pic_add_pressed.png"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(100, 100, kScreenWidth - 200, 100);
    [self.view addSubview:addBtn];
}


-(void)btnAction:(id)sender{
    if(sender == addBtn){
        [PopSignUtil getSignWithVC:self withOk:^(UIImage *image) {
            NSLog(@"image");
            [PopSignUtil closePop];
            [addBtn setBackgroundImage:image forState:UIControlStateNormal];
            [addBtn setTitle:@"" forState:UIControlStateNormal];
        } withCancel:^{
            NSLog(@"");
            [PopSignUtil closePop];
        }];
    }
}

@end
