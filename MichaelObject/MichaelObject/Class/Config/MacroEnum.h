//
//  MacroEnum.h
//  MichaelObject
//
//  Created by 卢达洋 on 2016/11/15.
//  Copyright © 2016年 卢达洋. All rights reserved.
//

#ifndef MacroEnum_h
#define MacroEnum_h

//NS_ENUM，定义状态等普通枚举
typedef NS_ENUM(NSInteger, DataRequestType) {
  DataRequestTypeInit = 0,
  DataRequestTypeRefresh ,
  DataRequestTypeLoadMore
};

//NS_OPTIONS，定义选项
typedef NS_OPTIONS(NSUInteger, MDirection) {
  MDirectionNone = 0,
  MDirectionTop = 1 << 0,
  MDirectionLeft = 1 << 1,
  MDirectionRight = 1 << 2,
  MDirectionBottom = 1 << 3
};

#endif /* MacroEnum_h */
