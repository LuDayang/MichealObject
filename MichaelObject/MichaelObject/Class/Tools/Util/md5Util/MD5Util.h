//
//  MD5Util.h
//  iOSLibraryDemo
//
//  Created by Lu on 15/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Util : NSObject
/**
 *  MD5加密
 *
 *  @param inputStr 未加密字符串
 *
 *  @return MD5加密后的字符串
 */
+ (NSString *)md5HexDigest:(NSString*)inputStr;
+ (NSString *)md5:(NSString *)inPutText;
+ (NSString*)md532BitLower:(NSString *)heheda;
@end
