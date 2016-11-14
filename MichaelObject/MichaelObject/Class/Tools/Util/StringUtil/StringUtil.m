//
//  StringUtil.m
//  iOSLibraryDemo
//
//  Created by Lu on 16/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil
+ (BOOL)isBlankString:(NSString *)string {
  if (string == nil || string == NULL) {
    return YES;
  }
  if ([string isKindOfClass:[NSNull class]]) {
    return YES;
  }
  if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
    return YES;
  }
  return NO;
}

+ (BOOL)isValidateEmail:(NSString *)email {
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile {
  if ([self isPureInt:mobile] && mobile.length == 11) {
    NSString *phoneRegex = @"^1+[34578]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
  }else{
    return NO;
  }
}

+ (BOOL)isPureInt:(NSString *)string {
  NSScanner *scan = [NSScanner scannerWithString:string];
  int val;
  return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureLetter:(NSString *)string {
  NSString *regex = @"[A-Za-z]+";;
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
  return [predicate evaluateWithObject:string];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
  if (jsonString == nil) {
    return nil;
  }
  
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
  if(err) {
    NSLog(@"json解析失败：%@",err);
    return nil;
  }
  return dic;
}

+ (NSString *)getImgUrlWithHTML:(NSString *)html{
  NSString *Prefix = @"http:";
  NSString *Suffix = @".jpg";
  NSRange start = [html rangeOfString:Prefix];
  NSRange end = [html rangeOfString:Suffix];
  NSRange rang;
  rang.location = start.location;
  rang.length = end.location - start.location + end.length;
  html = [html substringWithRange:rang];
  NSLog(@"%@",html);
  return html;
}

+ (int)PureNumber:(NSString*)str{
  for(int i = 0;i<str.length; i++){
    unichar c=[str characterAtIndex:i];
    if(c >'0' && c<'9')
      return i;
  }
  return 0;
}

+ (BOOL)isVersion:(NSString*)versionNow biggerThanVersion:(NSString*)versionNew
{
  NSArray *arrayNow = [versionNow componentsSeparatedByString:@"."];
  NSArray *arrayNew = [versionNew componentsSeparatedByString:@"."];
  BOOL isBigger = NO;
  NSInteger i = arrayNew.count > arrayNow.count? arrayNow.count : arrayNew.count;
  NSInteger j = 0;
  BOOL hasResult = NO;
  for (j = 0; j < i; j ++) {
    NSString* strNew = [arrayNew objectAtIndex:j];
    NSString* strNow = [arrayNow objectAtIndex:j];
    if ([strNew integerValue] > [strNow integerValue]) {
      hasResult = YES;
      isBigger = YES;
      break;
    }
    if ([strNew integerValue] < [strNow integerValue]) {
      hasResult = YES;
      isBigger = NO;
      break;
    }
  }
  if (!hasResult) {
    if (arrayNew.count > arrayNow.count) {
      NSInteger nTmp = 0;
      NSInteger k = 0;
      for (k = arrayNow.count; k < arrayNew.count; k++) {
        nTmp += [[arrayNew objectAtIndex:k]integerValue];
      }
      if (nTmp > 0) {
        isBigger = YES;
      }
    }
  }
  return isBigger;
}

@end
