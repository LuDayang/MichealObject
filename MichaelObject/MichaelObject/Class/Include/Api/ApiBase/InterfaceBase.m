//
//  InterfaceBase.m
//  ApplePayDemo
//
//  Created by chengjian on 16/4/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "Global.h"
#import "InterfaceBase.h"
@implementation InterfaceBase
- (instancetype)initWithPath:(NSString *)path {
  self = [super init];
  if (self) {
    NSString *host = [ApiBase shareInstance].host;
      _interfaceURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",host,path]];
      
  }
  return self;
}

- (NSString *)getTheTimeStamp {
  NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
  NSString *timestamp = [NSString stringWithFormat:@"%.0f", interval];
  return timestamp;
}

- (NSString *)ret32bitString

{
  char data[32];
  for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))))
    ;
  return [[NSString alloc] initWithBytes:data
                                  length:32
                                encoding:NSUTF8StringEncoding];
}

- (NSString *)getTheSignWithTimeStamp:(NSString *)timeStamp
                             noncestr:(NSString *)noncest {
  NSString *sign =
      [NSString stringWithFormat:@"ABCDEFGHIJKLMNOP%@%@", noncest, timeStamp];
  NSString *str2 = [MD5Util md5:sign];
  NSLog(@"str2 %@", str2);
  NSLog(@"sign %@", sign);
  return str2;
}

//加密POST数据
+ (NSString *)encryptPostDataString:(NSString *)postDataString {
#if OPEN_ENCRYPTION
  NSString *encryptDataString =
      [EncryptorXXTEA XXTEAEncryptStr:postDataString key:kAESENCODEKEY];
  return encryptDataString;
#else
  return postDataString;
#endif
}

//解密服务器返回数据
+ (NSDictionary *)decryptResponseData:(id)responseData {

#if OPEN_ENCRYPTION
  if ([responseData isKindOfClass:[NSDictionary class]]) {
    return responseData;
  }
  NSString *encryptDataString = responseData;
  NSDictionary *responseObject;
  NSString *responsStr =
      [EncryptorXXTEA XXTEADEncryptStr:encryptDataString key:kAESENCODEKEY];
  if (responsStr != nil && responsStr.length > 0) {
    responseObject = [NSJSONSerialization
        JSONObjectWithData:[responsStr dataUsingEncoding:NSUTF8StringEncoding]
                   options:NSJSONReadingMutableLeaves
                     error:nil];
  } else {
    return nil;
  }
  return responseObject;
#else
  return responseData;
#endif
}

#pragma mark POST请求
+ (void)postRequestWithUrl:(NSString *)url
                Parameters:(NSDictionary *)parameters
                completion:(completion_api)completion
                     error:(error_api)apiError {
  NSDictionary *postParameter;
  postParameter = parameters ? @{
                                   @"json" : [self encryptPostDataString:[parameters JSONString]]
                                   } : nil;
  AFHTTPSessionManager *manager = [ApiBase shareInstance].shareManager;
//  NSString *token = [AccountModel currentAccount].token;
//  token = token ? token : @"";
//  [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//    NSDictionary *requestSerializer =manager.requestSerializer.HTTPRequestHeaders;
//    NSLog(@"HTTPRequestHeaders%@",requestSerializer);
  [manager POST:url
      parameters:postParameter
      progress:^(NSProgress *_Nonnull uploadProgress) {

      }
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        NSDictionary *Object;
#if OPEN_ENCRYPTION
        Object = [InterfaceBase
            decryptResponseData:[responseObject objectForKey:@"json"]];
#else
        Object = responseObject;
#endif

        [InterfaceBase handleResponseObjectWithRequestType:POSTRequest
                                                       Url:url
                                                Parameters:postParameter
                                             ResponseObjec:Object
                                                completion:completion
                                                     error:apiError];
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [InterfaceBase handleRequestFailureType:POSTRequest
                                            Url:url
                                     Parameters:parameters
                                        NSError:error
                                          error:apiError];
      }];
}

#pragma mark GTE请求
+ (void)getRequestWithUrl:(NSString *)url
               Parameters:(NSDictionary *)parameters
               completion:(completion_api)completion
                    error:(error_api)apiError {

    AFHTTPSessionManager *manager = [ApiBase shareInstance].shareManager;
//    NSString *token = [AccountModel currentAccount].token;
//    token = token ? token : @"";
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//    NSDictionary *requestSerializer =manager.requestSerializer.HTTPRequestHeaders;
//    NSLog(@"HTTPRequestHeaders%@",requestSerializer);
  [manager GET:url
      parameters:parameters
      progress:^(NSProgress *_Nonnull downloadProgress) {

      }
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        NSDictionary *Object = responseObject;
        [InterfaceBase handleResponseObjectWithRequestType:GETRequest
                                                       Url:url
                                                Parameters:parameters
                                             ResponseObjec:Object
                                                completion:completion
                                                     error:apiError];

      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [InterfaceBase handleRequestFailureType:POSTRequest
                                            Url:url
                                     Parameters:parameters
                                        NSError:error
                                          error:apiError];
      }];
}

#pragma mark 图片上传
+ (NSURLSessionDataTask *)postDataRequestWithUrl:(NSString *)url
                       fileURL:(NSURL *)urlImage
                    parameters:(NSDictionary *)parameters
                      progress:(void(^)(NSProgress * uploadProgress))progress
                    completion:(void (^)(BOOL success, id resultObject,
                                         NSString *errorcode, NSString *msg,
                                         NSString *type))completion
                         error:(error_api)apiError {
  AFHTTPSessionManager *manager = [ApiBase shareInstance].shareManager;
//  NSString *token = [AccountModel currentAccount].token;
//  token = token ? token : @"";
//  [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
   NSDictionary * postParameter = parameters ? @{
                                   @"json" : [self encryptPostDataString:[parameters JSONString]]
                                   } : nil;
  NSURLSessionDataTask *task = [manager POST:url parameters:postParameter constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSError *error;
        BOOL suc = [formData appendPartWithFileURL:urlImage
                                              name:@"image"
                                             error:&error];
        NSLog(@"%d", suc);
      }
      progress:^(NSProgress *_Nonnull uploadProgress) {
          if (progress) {
               progress(uploadProgress);
          }
         
      }
      success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {

        NSDictionary *dic;
#if OPEN_ENCRYPTION
          dic = [InterfaceBase
                 decryptResponseData:[responseObject objectForKey:@"json"]];
#else
          dic = responseObject;
#endif

#if SHOW_INTFACE_LOGO
        NSLog(@"POSTRequestLog");
        NSLog(@"url = %@", url);
        NSLog(@"parameters = %@", parameters);
        NSLog(@"responseObjec = %@", dic);
#endif

        BOOL success = [[dic objectForKey:@"success"] boolValue];
        NSString *code = [dic objectForKey:@"code"];
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *type = dic[@"type"];
        if (!success) {
          completion(success, nil, code, msg, type);
        } else {
          completion(success, dic, code, msg, type);
        }
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {

        [InterfaceBase handleRequestFailureType:POSTRequest
                                            Url:url
                                     Parameters:parameters
                                        NSError:error
                                          error:apiError];
      }];
    return task;
}

#pragma mark 处理成功返回的数据
+ (void)handleResponseObjectWithRequestType:(QequestType)requestType
                                        Url:(NSString *)url
                                 Parameters:(NSDictionary *)parameters
                              ResponseObjec:(NSDictionary *)responseObjec
                                 completion:(completion_api)completion
                                      error:(error_api)apiError {
//打印接口日志
#if SHOW_INTFACE_LOGO
  NSString *RequestType;
  if (requestType == POSTRequest) {
    RequestType = @"POSTRequest";
  } else {
    RequestType = @"GETRequest";
  }
  NSLog(@"%@Log", RequestType);
  NSLog(@"url = %@", url);
  NSLog(@"parameters = %@", parameters);
  NSLog(@"responseObjec = %@", responseObjec.description);
#endif

  BOOL success = [[responseObjec objectForKey:@"success"] boolValue];
  NSString *code = [responseObjec objectForKey:@"code"];
  NSString *msg = [responseObjec objectForKey:@"msg"];
    
    NSLog(@"msg%@",msg);
    
  NSMutableDictionary *object = nil;
  if (success) {
    NSInteger type = [[responseObjec objectForKey:@"type"] integerValue];

    if (type == 1) {
      object = [NSMutableDictionary
          dictionaryWithDictionary:[responseObjec objectForKey:@"content"]];
    } else if (type == 2) {
      object = [NSMutableDictionary
          dictionaryWithDictionary:[responseObjec objectForKey:@"collection"]];
    }else{
      object = [NSMutableDictionary
          dictionaryWithDictionary:[responseObjec objectForKey:@"content"]];
    }
  }
  if ([code isEqualToString:@"tokenInvalid"]) {
    //处理token失效
//    [AccountModel logoutAccount];
//    SEND_NSNotificationCenter(@"tokenInvalid");
  }
  completion(success, object, code, msg);
}

#pragma mark 处理接口请求失败
+ (void)handleRequestFailureType:(QequestType)requestType
                             Url:(NSString *)url
                      Parameters:(NSDictionary *)parameters
                         NSError:(NSError *)error
                           error:(error_api)apiError {
#if SHOW_INTFACE_LOGO
  NSString *RequestType;
  if (requestType == POSTRequest) {
    RequestType = @"POSTRequest";
  } else {
    RequestType = @"GETRequest";
  }
  NSLog(@"%@Log", RequestType);
  NSLog(@"url = %@", url);
  NSLog(@"parameters = %@", parameters);
  NSLog(@"error = %@", error.description);
#endif
  apiError(error);
}

@end
