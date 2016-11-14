//
//  InterfaceBase.h
//  ApplePayDemo
//
//  Created by chengjian on 16/4/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "ApiBase.h"
#import "AppConfig.h"
#import "MD5Util.h"
#import <Foundation/Foundation.h>
#import <JSONKit.h>

#define CREATE_REAL_URL(baseURL, path)                                         \
  [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseURL, path]]

typedef NS_ENUM(NSInteger, QequestType) { POSTRequest, GETRequest };
@class AFHTTPSessionManager;

typedef void (^completion_api)(BOOL success, id resultObject,
                               NSString *errorcode, NSString *msg);
typedef void (^error_api)(NSError *error);

typedef void (^completion_List)(BOOL success, NSString *errorcode,
                                NSString *msg, BOOL hasNext, BOOL hasPrevious,
                                NSString *totalPage, NSArray *ListData);

@interface InterfaceBase : NSObject
@property(nonatomic, strong) NSURL *interfaceURL;

- (id)initWithPath:(NSString *)path;
- (NSString *)ret32bitString;
- (NSString *)getTheTimeStamp;
- (NSString *)getTheSignWithTimeStamp:(NSString *)timeStamp
                             noncestr:(NSString *)noncest;

//加密POST数据
+ (NSString *)encryptPostDataString:(NSString *)postDataString;
//解密服务器返回数据
+ (NSDictionary *)decryptResponseData:(id)responseData;

+ (void)postRequestWithUrl:(NSString *)url
                Parameters:(NSDictionary *)parameters
                completion:(completion_api)completion
                     error:(error_api)apiError;

+ (void)getRequestWithUrl:(NSString *)url
               Parameters:(NSDictionary *)parameters
               completion:(completion_api)completion
                    error:(error_api)apiError;

//单独上传图片,附加fileURL
+ (NSURLSessionDataTask *)postDataRequestWithUrl:(NSString *)url
                       fileURL:(NSURL *)urlImage
                    parameters:(NSDictionary *)parameters
                      progress:(void(^)(NSProgress * uploadProgress))progress
                    completion:(void (^)(BOOL success, id resultObject,
                                         NSString *errorcode, NSString *msg,
                                         NSString *type))completion
                         error:(error_api)apiError;

//处理请求回来的数据
+ (void)handleResponseObjectWithRequestType:(QequestType)requestType
                                        Url:(NSString *)url
                                 Parameters:(NSDictionary *)parameters
                              ResponseObjec:(NSDictionary *)responseObjec
                                 completion:(completion_api)completion
                                      error:(error_api)apiError;

//处理失败的网络请求
+ (void)handleRequestFailureType:(QequestType)requestType
                             Url:(NSString *)url
                      Parameters:(NSDictionary *)parameters
                         NSError:(NSError *)error
                           error:(error_api)apiError;

@end
