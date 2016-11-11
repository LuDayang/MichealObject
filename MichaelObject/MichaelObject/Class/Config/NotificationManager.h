//
//  NotificationManager.h
//  GuoJian
//
//  Created by GikkiAres on 2016/10/20.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#ifndef NotificationManager_h
#define NotificationManager_h

#define LocatePointNotification @"LocatePointNotification"

//注册本地消息
#define REGIST_NSNotificationCenter(execAction,NotificationName) \
[[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(execAction) \
name:NotificationName \
object:nil];


//发送本地消息
#define SEND_NSNotificationCenter(NotificationName) \
[[NSNotificationCenter defaultCenter] \
postNotificationName:NotificationName \
object:nil];

//发送本地消息带参数
#define SEND_NSNotificationCenter_And_Param(NotificationName,param) \
[[NSNotificationCenter defaultCenter] \
postNotificationName:NotificationName \
object:param];

//注册通知带参数
#define REGIST_NSNotificationCenter_PARAMETRS(notificationFunction,notificationName) \
[[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(notificationFunction:) \
name:notificationName \
object:nil];

//备案列表需要刷新的通知.
#define RecordListNeedRefreshNotification @"RecordListNeedRefreshNotification"

//登录成功和注销的通知
#define LOGOUTSUCCESS       @"LogoutSuccess"
#define LOGINSUCCESS        @"LoginSuccess"
#define UserStateChanged    @"UserStateChanged"


#endif /* NotificationManager_h */
