//
//  JPushUtil.m
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/13.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import "ConstantData.h"
#import "Global.h"
#import "JPushUtil.h"
#import "Config.h"
//#import "SysNotificationVC.h"
//#import "AccountModel.h"
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@implementation JPushUtil

+ (void)setupWithOptions:(NSDictionary *)launchOptions {
// Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
  // ios8之后可以自定义category
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    // 可以添加自定义categories
    [JPUSHService
        registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                            UIUserNotificationTypeSound |
                                            UIUserNotificationTypeAlert)
                                categories:nil];
  } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    // ios8之前 categories 必须为nil
    [APService
        registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                            UIRemoteNotificationTypeSound |
                                            UIRemoteNotificationTypeAlert)
                                categories:nil];
#endif
  }
#else
  // categories 必须为nil
  [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
                                     categories:nil];
#endif

  // Required
  [JPUSHService setupWithOption:launchOptions
                         appKey:kJPushAppKey
                        channel:channel
               apsForProduction:isProduction
          advertisingIdentifier:nil];
  ;
  return;
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
  [JPUSHService registerDeviceToken:deviceToken];
  return;
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo
                      completion:(void (^)(UIBackgroundFetchResult))completion {
  [JPUSHService handleRemoteNotification:userInfo];
        [JPushUtil pushVCWith:userInfo];
}


+ (void)pushVCWith:(NSDictionary *)userInfo {
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoteNotification" object:userInfo];
}

@end
