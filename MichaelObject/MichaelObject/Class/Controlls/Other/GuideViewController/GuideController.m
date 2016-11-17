//
//  GuideController.m
//  QianZhenyn
//
//  Created by 卢达洋 on 16/7/25.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "GuideController.h"
#import "Master.h"
@interface GuideController ()<UIPageViewControllerDelegate,UIScrollViewDelegate>
@property(weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageContril;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
//@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isTimer;
@end

@implementation GuideController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)initView {
  for (int i = 0; i < 5; i++) {
    NSString *imageName =
        [NSString stringWithFormat:@"guide%d", i + 1];
    
    if (i == 3) {
      UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth,kScreenHeight)];
      UIImageView *imageView = [[UIImageView alloc]
                                initWithFrame:CGRectMake(0, 0, kScreenWidth,
                                                         kScreenHeight)];
      imageView.image = [UIImage imageNamed:imageName];
        imageView.userInteractionEnabled = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2 - 56, kScreenHeight/667*580, 111, kScreenHeight/667*39);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"立即进入" forState:UIControlStateNormal];
        [button setTitleColor:RGBACOLOR(11, 183, 137, 1) forState:UIControlStateNormal];

        
//        边框宽度
        [button.layer setBorderWidth:1.0];
        button.layer.borderColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1].CGColor;
        
        [button makeRoundedCorner:3];

        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(GoHomeView:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
        
      [lastView addSubview:imageView];
      [_scrollerView addSubview:lastView];
    }else{
      UIImageView *imageView = [[UIImageView alloc]
                                initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth,
                                                         kScreenHeight)];
      imageView.image = [UIImage imageNamed:imageName];
      [_scrollerView addSubview:imageView];
    }
    
    
  }
  _pageContril.numberOfPages = 4;
  _pageContril.userInteractionEnabled = NO;
  _scrollerView.pagingEnabled = YES;
  _scrollerView.showsVerticalScrollIndicator = NO;
  _scrollerView.showsHorizontalScrollIndicator = NO;
  _scrollerView.bounces = NO;
  _scrollerView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight);

}

- (void)scrollRolling {
    CGPoint point = self.scrollerView.contentOffset;
    point.x += self.scrollerView.frame.size.width;
    [self.scrollerView setContentOffset:point animated:YES];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  if (scrollView.contentOffset.x < kScreenWidth * 2.5) {
    _jumpBtn.hidden = NO;
  }else{
    _jumpBtn.hidden = YES;
  }
  int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
  _pageContril.currentPage = index;
  
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _pageContril.currentPage = index;
    if (scrollView.contentOffset.x < kScreenWidth * 2.5) {
        _jumpBtn.hidden = NO;
    }else{
        _jumpBtn.hidden = YES;
    }
}

- (IBAction)GoHomeView:(UIButton *)sender {

    
  Master *vc = [[Master alloc] init];

  typedef void (^Animation)(void);
  UIWindow* window = [UIApplication sharedApplication].keyWindow;
  
  // 淡入淡出显示首页
  vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  Animation animation = ^{
    BOOL oldState = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [UIView setAnimationsEnabled:oldState];
  };
  [UIView transitionWithView:window
                    duration:0.5f
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:animation
                  completion:nil];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
