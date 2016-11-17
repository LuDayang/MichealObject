//
//  BaseListController.m
//  MichaelObject
//
//  Created by 卢达洋 on 2016/11/15.
//  Copyright © 2016年 卢达洋. All rights reserved.
//

#import "BaseListController.h"

@interface BaseListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSString *pageNumber;
@end

@implementation BaseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{

}

- (void)RequestDataWith:(DataRequestType)Type {
  switch (Type) {
    case DataRequestTypeInit:
    {
      self.pageNumber = @"1";
    }
      break;
    case DataRequestTypeRefresh:
    {
      self.pageNumber = @"1";
    }
      break;
    case DataRequestTypeLoadMore:
    {
      NSInteger page = [self.pageNumber integerValue];
      page ++;
      self.pageNumber = [NSString stringWithFormat:@"%li",(long)page ];
    }
      break;
      
    default:
      break;
  }
  [self.view makeToastActivity:CSToastPositionCenter];
  if (Type == DataRequestTypeInit) {
    _dataArr = [NSMutableArray new];
  }else if (Type == DataRequestTypeRefresh){
    [_dataArr removeAllObjects];
  }else{
    
  }
  [_tableView.mj_header endRefreshing];
  [_tableView.mj_footer endRefreshingWithNoMoreData];
  [_tableView.mj_footer endRefreshing];
}

-(void)initView{
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
  __weak typeof(self) weakSelf=self;
  _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [weakSelf RequestDataWith:DataRequestTypeRefresh];
  }];
  _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    [weakSelf RequestDataWith:DataRequestTypeLoadMore];
  }];
}

#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.dataArr.count;
}
@end
