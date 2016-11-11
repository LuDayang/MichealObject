//
//  NSString-DYExtension.h
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (DYExtension)

#pragma mark - 正则判断
/**
 *  判断字符串是否为邮箱地址
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheEmail;
/**
 *  判断字符串是否为合法手机号码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheMobile;
/**
 *  判断字符串是否为固定电话
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheTelephone;
/**
 *  判断字符串是否符合用户名规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheUsername;
/**
 *  判断字符串是否符合密码规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatchePassword;
/**
 *  判断字符串是否符合QQ号码格式
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheQQ;
/**
 *  判断字符串是否符合邮政编码规则
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatchePostcode;
/**
 *  判断字符串是否全部属于中文字符
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheCHS;
/**
 *  判断字符串是否为IP地址
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheIPaddress;
/**
 *  判断字符串是否为身份证号码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheIDNumber;

/**
 *  判断字符串是否为纯数字
 *
 *  @param string 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)isPureInt:(NSString *)string;

/**
 *  判断字符串首字符是否纯字母
 *
 *  @param string 待判断的字符串
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)isPureLetter:(NSString *)string;

/**
 *  判断两个版本大小
 *
 *  @param versionA 版本A
 *  @param versionB 版本B
 *
 *  @return 版本A是否高于版本B
 */
- (BOOL)isVersion:(NSString *)versionA biggerThanVersion:(NSString *)versionB;

- (NSDictionary *)getUrlInputDictional;

- (CGFloat)heightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize;
//补全图片Url路径
-(NSString *)competionImageUrl;
@end
