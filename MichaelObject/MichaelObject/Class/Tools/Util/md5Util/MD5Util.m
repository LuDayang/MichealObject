//
//  MD5Util.m
//  iOSLibraryDemo
//
//  Created by Lu on 15/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "MD5Util.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5Util
+ (NSString *)md5HexDigest:(NSString*)inputStr{
  /**
   *  转换成utf-8
   */
  const char *cStr = [inputStr UTF8String];
  
  /**
   *  开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
   */
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  
  CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
  /*
   extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
   把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
   */
  
  NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
  for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    /**
     *  x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     */
    [ret appendFormat:@"%02X",result[i]];
  }
  return ret;
}

+ (NSString *)md5:(NSString *)inPutText
{
  const char *cStr = [inPutText UTF8String];
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
  
  return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ] uppercaseString];
}

+ (NSString*)md532BitLower:(NSString *)heheda
{
  const char *cStr = [heheda UTF8String];
  unsigned char result[16];
  
  NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
  CC_MD5( cStr,[num intValue], result );
  
  return [[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ] uppercaseString];
}
@end
