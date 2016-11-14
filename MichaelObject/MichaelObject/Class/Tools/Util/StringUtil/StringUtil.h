//
//  StringUtil.h
//  iOSLibraryDemo
//
//  Created by Lu on 16/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

#pragma mark 判断类方法
/**
 *  判断是否为空字符串
 *
 *  @param string 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  判断字符串是否为邮箱地址
 *
 *  @param email 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  判断字符串是否为合法手机号码
 *
 *  @param mobile 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  判断字符串是否为纯数字
 *
 *  @param string 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  判断字符串首字符是否纯字母
 *
 *  @param string 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
+ (BOOL)isPureLetter:(NSString *)string;

/**
 *  字符串转字典
 *
 *  @param jsonString Json格式字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  获取html源码中的图片地址
 *
 *  @param html html源码字符串
 *
 *  @return 图片地址
 */
+ (NSString *)getImgUrlWithHTML:(NSString *)html;

/**
 *  判断string多少位开始才是数字
 *
 *  @param str 源字符
 *
 *  @return 出现数字字符的索引
 */
+ (int)PureNumber:(NSString*)str;

/**
 *  版本比较
 *
 *  @param versionNow 当前版本号
 *  @param versionNew 新版本号
 *
 *  @return 新版本号是否高于当前版本号
 */
+ (BOOL)isVersion:(NSString*)versionNow biggerThanVersion:(NSString*)versionNew;
@end
