//
//  NSString+DYExtension.m
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import "NSString+DYExtension.h"
#import "ConstantData.h"
static  NSString *emailRegex     = @"\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
static  NSString *mobileRegex    = @"0?(13|14|15|18|17)[0-9]{9}";
static  NSString *telephoneRegex = @"[0-9-()（）]{7,18}";
static  NSString *usernameRegex  = @"[A-Za-z0-9_\\-\\u4e00-\\u9fa5]+";
static  NSString *passwordRegex  = @"(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,})$";
static  NSString *QQRegex        = @"[1-9]([0-9]{5,11})";
static  NSString *postcodeRegex  = @"\\d{6}";
static  NSString *CHSRegex       = @"[\\u4e00-\\u9fa5]";
static  NSString *IPAddressRegex = @"(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)";
static  NSString *IDNumberRegex  = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
//\\d{17}[\\d|x]|\\d{15}
@implementation NSString (DYExtension)

#pragma mark - 正则判断实现方法
/**
 *  正则判断实现方法
 *
 *  @param expression 正则表达式
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regularJudgmentWithExpression:(NSString *)expression {
  NSPredicate *expressionTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
  return [expressionTest evaluateWithObject:self];
}


/**
 *  判断字符串是否为邮箱地址
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheEmail{
  return [self regularJudgmentWithExpression:emailRegex];
}
/**
 *  判断字符串是否为合法手机号码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheMobile{
  return [self regularJudgmentWithExpression:mobileRegex];
}
/**
 *  判断字符串是否为固定电话
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheTelephone{
  return [self regularJudgmentWithExpression:telephoneRegex];
}
/**
 *  判断字符串是否符合用户名规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheUsername{
  return [self regularJudgmentWithExpression:usernameRegex];
}
/**
 *  判断字符串是否符合密码规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatchePassword{
  return [self regularJudgmentWithExpression:passwordRegex];
}
/**
 *  判断字符串是否符合QQ号码格式
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheQQ{
  return [self regularJudgmentWithExpression:QQRegex];
}
/**
 *  判断字符串是否符合邮政编码规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatchePostcode{
  return [self regularJudgmentWithExpression:postcodeRegex];
}
/**
 *  判断字符串是否全部属于中文字符
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheCHS{
  return [self regularJudgmentWithExpression:CHSRegex];
}
/**
 *  判断字符串是否为IP地址
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheIPaddress{
  return [self regularJudgmentWithExpression:IPAddressRegex];
}
/**
 *  判断字符串是否为身份证号码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheIDNumber{
  return [self regularJudgmentWithExpression:IDNumberRegex];
}

#pragma mark - 正则判断
- (BOOL)isValidateEmail:(NSString *)email {
  NSString *emailRegex = @"\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

- (BOOL)isValidateMobile:(NSString *)mobile {
  if ([self isPureInt:mobile] && mobile.length == 11) {
    NSString *phoneRegex = @"0?(13|14|15|18|17)[0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
  }else{
    return NO;
  }
}

- (BOOL)isPureInt:(NSString *)string {
  NSScanner *scan = [NSScanner scannerWithString:string];
  int val;
  return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureLetter:(NSString *)string {
  NSString *regex = @"[A-Za-z]+";;
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
  return [predicate evaluateWithObject:string];
}

- (BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB{
  NSArray *arrayNow = [versionB componentsSeparatedByString:@"."];
  NSArray *arrayNew = [versionA componentsSeparatedByString:@"."];
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

-(NSDictionary *)getUrlInputDictional{
  
  NSString *str = [[self componentsSeparatedByString:@"//"]lastObject];
  NSArray *content = [str componentsSeparatedByString:@"&"];
  NSMutableDictionary *diction = [NSMutableDictionary new];
  if (content) {
    for (NSString *item in content) {
      [diction setValue:[[item componentsSeparatedByString:@"="]lastObject] forKey:[[item componentsSeparatedByString:@"="]firstObject]];
    }
  }
  return diction;
}

// 获取string的高度 (限定宽度为width, 字体大小为fontSize)
- (CGFloat)heightWithWidth:(CGFloat)width
                   fontSize:(CGFloat)fontSize {
  CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] } context:nil];
  
  return rect.size.height;
}

-(NSString *)competionImageUrl{
    return [NSString stringWithFormat:@"%@%@",kAPI_HOST,self];
}
@end
