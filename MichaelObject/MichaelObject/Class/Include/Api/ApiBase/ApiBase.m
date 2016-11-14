//
//  ApiBase.m
//  ApplePayDemo
//
//  Created by chengjian on 16/4/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "ApiBase.h"
#define TIMEOUT 30

static ApiBase *_instance = nil;
static AFHTTPSessionManager *_shareSessionManager = nil;
@implementation ApiBase
+ (ApiBase *)shareInstance
{
  if (!_instance) {
    @synchronized (self) {
      if (!_instance) {
        _instance = [[self alloc] init];
      }
    }
  }
  return _instance;
}

- (void)setHost:(NSString *)host {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if (host != nil) {
    [defaults setObject:host forKey:kAPI_HOST];
  } else {
    [defaults removeObjectForKey:kAPI_HOST];
  }
  [defaults synchronize];
}

- (NSString *)host {
  NSString *host =
  [[NSUserDefaults standardUserDefaults] stringForKey:kAPI_HOST];
  if (!host) {
    host = kAPI_HOST;
  }
  return host;
}

- (void)setAppCodeKey:(NSString *)appcodeKey
         appCodeValue:(NSString *)appCodeValue {
  self.appCodeKey = appcodeKey;
  self.appCodeValue = appCodeValue;
}

- (AFHTTPSessionManager *)shareManager {
  if (!_shareSessionManager) {
    @synchronized(self) {
      if (!_shareSessionManager) {
        _shareSessionManager = [AFHTTPSessionManager manager];
        _shareSessionManager.requestSerializer =
        [AFHTTPRequestSerializer serializer];
        _shareSessionManager.responseSerializer =
        [AFJSONResponseSerializer serializer];
        _shareSessionManager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"application/json", @"text/json",
         @"text/javascript", @"text/html",
         @"text/plain", nil];
        // 超时设置
        _shareSessionManager.requestSerializer.timeoutInterval = TIMEOUT;
          NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        [_shareSessionManager.requestSerializer setValue:version forHTTPHeaderField:@"version"];
          [_shareSessionManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"os"];
      }
    }
  }
  return _shareSessionManager;
}

@end
