//
//  BaseWebController.m
//  MichaelObject
//
//  Created by 卢达洋 on 2016/11/15.
//  Copyright © 2016年 卢达洋. All rights reserved.
//

#import "BaseWebController.h"
#import <WebKit/WebKit.h>

@interface BaseWebController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation BaseWebController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
  [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
  self.webView.navigationDelegate = self;
  MJRefreshNormalHeader *logHeader =
  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [self endHeaderRefreshing];
  }];
  self.webView.scrollView.delegate = self;
  self.webView.scrollView.mj_header = logHeader;
  self.webView.scrollView.mj_header.alpha = 0;
  [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endHeaderRefreshing {
  [self.webView.scrollView.mj_header endRefreshing];
  [self.webView reload];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView.contentOffset.y < -64) {
    self.webView.scrollView.mj_header.alpha = -1 * (1- scrollView.contentOffset.y / -64);
  }
  else {
    self.webView.scrollView.mj_header.alpha = 0;
    
  }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
  [self.view makeToastActivity:CSToastPositionCenter];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  [self.view hideToastActivity];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
  [self.view hideToastActivity];
  [self.view makeToast:@"加载失败，请检查网络"
              duration:1
              position:CSToastPositionCenter];
}
@end
