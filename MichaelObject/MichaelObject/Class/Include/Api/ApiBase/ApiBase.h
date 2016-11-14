//
//  ApiBase.h
//  ApplePayDemo
//
//  Created by chengjian on 16/4/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "JSONKit.h"
#import "Config.h"
@class AFHTTPSessionManager;


@interface ApiBase : NSObject
+ (ApiBase *)shareInstance;

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *appCodeKey;
@property (nonatomic, copy) NSString *appCodeValue;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *shareManager;

- (void)setAppCodeKey:(NSString *)appcodeKey appCodeValue:(NSString *)appCodeValue;
@end
